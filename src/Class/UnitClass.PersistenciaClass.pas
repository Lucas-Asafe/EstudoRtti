unit UnitClass.PersistenciaClass;

interface

uses
  DB, System.Classes, System.Rtti, sysUtils, System.Generics.Collections,
  UnitClass.Helper.RTTI, UnitClass.CustomAttributes, utils.Str, Controller.ConnectionFactory,
  FireDAC.Comp.Client;

type
  TEditMode = (emInsert, emEdit, emNenhum);

  EPersistenciaClass = class(Exception);

  TProcPersistencia = procedure(classe: TObject; UsarTransacao: Boolean = False) of object;

  TPersistenciaClass = class
  private
    FConnection: TFDConnection;
    FIndices: string;
    FSQL: string;
    FSqlQry: TFDQuery;
    FTabela: string;
    RttiContexto: TRttiContext;
    function getFKField(classe: TObject): TObjectList<TRttiProperty>;
    function getNomeTabela(classe: TObject): string;
    function getIndicePK(classe: TObject): string;
    function getIndiceFK(classe: TObject): TDictionary<string, string>;
    function getCampos(classe: TObject): string;
    function getValores(classe: TObject): string;
    function getCampoValor(classe: TObject): string;
    function getValueFromProp(Value: TValue): string;
    function GetValueFK(classe: TObject): string;
    procedure CommitTransacao;
    procedure setFieldsDataSet(Dataset: TDataSet; classe: TObject);
  public
    function GetPKField(classe: TObject): TRttiProperty;
    procedure GetValoresFromDataset(Dataset: TDataSet; classe: TObject);
    procedure Insere(classe: TObject; UsarTransacao: Boolean = False);
    procedure Altere(classe: TObject; UsarTransacao: Boolean = False);
    procedure Delete(classe: TObject; UsarTransacao: Boolean = False);
    procedure ExecuteProcPersistencia(PLista: TObjectList<TObject>;
      ProcPersistencia: TProcPersistencia);
    procedure GetLista<T: class, constructor>(out lista: TObjectList<T>; condicaoSQL: string = '');
    procedure Get<T: class, constructor>(out objeto: T; PValorChave: Variant);
    function GetListaDoDataSet<T: class, constructor>(Dataset: TDataSet): TObjectList<T>;
    constructor Create;
  end;

implementation

uses
  Vcl.Dialogs;

{ TPersistenciaClass }

var
  RttiTipo: TRttiType;
  RttiProp: TRttiProperty;
  Atributo: TCustomAttribute;

procedure TPersistenciaClass.CommitTransacao;
begin
  try
    if FConnection.Transaction.Active then
      FConnection.Transaction.Commit;
  except
    on E: Exception do
    begin
      FConnection.Transaction.Rollback;
      raise EPersistenciaClass.Create('Erro ao comitar transação.');
    end;
  end;
end;

constructor TPersistenciaClass.Create;
begin
  FConnection := TConnection.GetConnection;
  FSqlQry := TFDQuery.Create(FConnection.Owner);

  FSqlQry.Connection := FConnection;

  RttiContexto := TRttiContext.Create;
end;

procedure TPersistenciaClass.Insere(classe: TObject; UsarTransacao: Boolean = False);
var
  campos: string;
  valores: string;
  objeto: TObject;
begin
  FTabela := getNomeTabela(classe);
  campos := getCampos(classe);
  valores := getValores(classe);

  FSQL := Format('INSERT INTO %s(%s) VALUES (%s);', [FTabela, campos, valores]);

  try
    if (UsarTransacao) and (not FConnection.Transaction.Active) then
      FConnection.Transaction.StartTransaction;

    FConnection.ExecSQL(FSQL.Replace('"', '', [rfReplaceAll]));

    for RttiProp in RttiContexto.GetType(classe.ClassType).GetProperties do
      if (RttiProp.GetAttribute(ADetalhe) <> nil) then
        ExecuteProcPersistencia(TObjectList<TObject>(RttiProp.GetValue(classe).AsObject), Insere);

    CommitTransacao;
  except
    raise EPersistenciaClass.Create('Erro ao inserir registro no banco de dados.');
  end;
end;

procedure TPersistenciaClass.Altere(classe: TObject; UsarTransacao: Boolean = False);
var
  valores: string;
  objeto: TObject;
begin
  FTabela := getNomeTabela(classe);
  valores := getCampoValor(classe);
  FIndices := getIndicePK(classe);

  FSQL := Format('UPDATE %s SET %s WHERE %s;', [FTabela, valores, FIndices]);

  try
//    FConnection.Transaction.Active := (UsarTransacao) and (not FConnection.Transaction.Active); // testar
    if (UsarTransacao) and (not FConnection.Transaction.Active) then
      FConnection.Transaction.StartTransaction;

    FConnection.ExecSQL(FSQL.Replace('"', '', [rfReplaceAll]));

    for RttiProp in RttiContexto.GetType(classe.ClassType).GetProperties do
      if (RttiProp.GetAttribute(ADetalhe) <> nil) then
        ExecuteProcPersistencia(TObjectList<TObject>(RttiProp.GetValue(classe).AsObject), Altere);

    CommitTransacao;
  except
    raise EPersistenciaClass.Create('Erro ao alterar registro no banco de dados.');
  end;
end;

procedure TPersistenciaClass.Delete(classe: TObject; UsarTransacao: Boolean = False);
begin
  FTabela := getNomeTabela(classe);
  FIndices := getIndicePK(classe);
  FSQL := Format('DELETE FROM %s WHERE %s;', [FTabela, FIndices]);

  try
    if (UsarTransacao) and (not FConnection.Transaction.Active) then
      FConnection.Transaction.StartTransaction;

    FConnection.ExecSQL(FSQL.Replace('"', '', [rfReplaceAll]));

    for RttiProp in RttiContexto.GetType(classe.ClassType).GetProperties do
      if (RttiProp.GetAttribute(ADetalhe) <> nil) then
        ExecuteProcPersistencia(TObjectList<TObject>(RttiProp.GetValue(classe).AsObject), Delete);

    CommitTransacao;
  except
    raise EPersistenciaClass.Create('Erro ao excluir registro no banco de dados.');
  end;
end;

procedure TPersistenciaClass.ExecuteProcPersistencia(PLista: TObjectList<TObject
  >; ProcPersistencia: TProcPersistencia);
var
  objeto: TObject;
begin
  for objeto in PLista do
    ProcPersistencia(objeto);
end;

procedure TPersistenciaClass.Get<T>(out objeto: T; PValorChave: Variant);
var
  LCampoValor: string;
begin
  objeto := T.Create;
  FTabela := getNomeTabela(objeto);
  LCampoValor := ACampo(GetPKField(objeto).GetAttribute(ACampo)).NomeDB + ' = '
    + QuotedStr(PValorChave);

  FSqlQry.Close;
  FSqlQry.SQL.Clear;
  FSqlQry.SQL.Text := Format('select * from %s where %S', [FTabela, LCampoValor]);
  FSqlQry.Open;

  GetValoresFromDataset(FSqlQry, objeto);
end;

procedure TPersistenciaClass.GetLista<T>(out lista: TObjectList<T>; condicaoSQL: string = '');
var
  objeto: T;
begin
  lista := TObjectList<T>.Create;
  FSqlQry.Close;
  FSqlQry.SQL.Clear;

  objeto := T.Create;
  FTabela := getNomeTabela(objeto);

  if not condicaoSQL.IsEmpty then
    condicaoSQL := 'WHERE ' + condicaoSQL;

  FSQL := Format('select * from %s %S', [FTabela, condicaoSQL]);
  FSqlQry.SQL.Add(FSQL);

  FSqlQry.Open;
  while not FSqlQry.Eof do
  begin
    objeto := T.Create;
    GetValoresFromDataset(FSqlQry, objeto);
    lista.Add(objeto);
    FSqlQry.Next;
  end;
end;

function TPersistenciaClass.GetListaDoDataSet<T>(DataSet: TDataSet): TObjectList<T>;
var
  objeto: T;
begin
  objeto := T.Create;
  Result := TObjectList<T>.Create;
  DataSet.First;
  while not DataSet.Eof do
  begin
    objeto := T.Create;
    GetValoresFromDataset(DataSet, objeto);
    Result.Add(objeto);
    DataSet.Next;
  end;
end;

function TPersistenciaClass.GetPKField(classe: TObject): TRttiProperty;
begin
  Result := nil;
  RttiTipo := RttiContexto.GetType(classe.ClassType);

  for RttiProp in RttiTipo.GetProperties do
  begin
    if RttiProp.isChavePrimaria then
      Exit(RttiProp)
  end;
end;

function TPersistenciaClass.getValueFromProp(value: TValue): string;
var
  f: TFormatSettings;
begin
  case value.Kind of
    tkUString:
      Result := value.ToString.QuotedString;
    tkInteger:
      Result := value.ToString;
    tkFloat:
      begin
        if (value.TypeInfo = TypeInfo(Real)) or (value.TypeInfo = TypeInfo(Double)) then
        begin
          f := TFormatSettings.Create();
          f.DecimalSeparator := '.';
          Result := value.AsExtended.ToString(f);
        end;

        if value.TypeInfo = TypeInfo(TDate) then
          Result := FormatDateTime('d-MMM-yyyy', value.AsExtended,
            TFormatSettings.Create('en-US')).QuotedString;

        if value.TypeInfo = TypeInfo(TTime) then
          Result := FormatDateTime('hh:mm:ss', value.AsExtended).QuotedString;

        if value.TypeInfo = TypeInfo(TDateTime) then
          Result := FormatDateTime('d-MMM-yyyy hh:mm:ss', value.AsExtended,
            TFormatSettings.Create('en-US')).QuotedString;
      end;
  end;
end;

function TPersistenciaClass.getValores(classe: TObject): string;
var
  s: TStringList;
  f: TFormatSettings;
begin
  s := TStringList.Create;

  RttiTipo := RttiContexto.GetType(classe.ClassType);

  for RttiProp in RttiTipo.GetProperties do
  begin
    if RttiProp.isCampoSimples then
    begin
      s.Add(getValueFromProp(RttiProp.GetValue(classe)));
    end
    else if (RttiProp.isChaveEstrangeira) then
    begin
      s.Add(GetValueFK(classe));
    end;
  end;

  s.StrictDelimiter := True;
  s.Delimiter := ',';
  Result := s.DelimitedText;
end;

procedure TPersistenciaClass.setFieldsDataSet(DataSet: TDataSet; classe: TObject);
var
  nomeField: string;
begin
  RttiTipo := RttiContexto.GetType(classe.ClassType);
  for RttiProp in RttiTipo.GetProperties do
  begin
    Atributo := RttiProp.GetAttribute(ACampo);
    nomeField := ACampo(Atributo).NomeDB;

    case RttiProp.GetValue(classe).Kind of
      tkUString:
        DataSet.FieldByName(nomeField).AsString := RttiProp.GetValue(classe).AsString;
      tkInteger:
        DataSet.FieldByName(nomeField).AsInteger := RttiProp.GetValue(classe).AsInteger;
      tkFloat:
        begin
          if RttiProp.GetValue(classe).TypeInfo = TypeInfo(Real) then
            DataSet.FieldByName(nomeField).AsFloat := RttiProp.GetValue(classe).AsExtended;

          if RttiProp.GetValue(classe).TypeInfo = TypeInfo(TDate) then
            DataSet.FieldByName(nomeField).AsDateTime := RttiProp.GetValue(classe).AsExtended;

          if RttiProp.GetValue(classe).TypeInfo = TypeInfo(TTime) then
            DataSet.FieldByName(nomeField).AsDateTime := RttiProp.GetValue(classe).AsExtended;
        end;
    end
  end;
end;

function TPersistenciaClass.getCampos(classe: TObject): string;
var
  s: TStringList;
begin
  s := TStringList.Create;

  RttiTipo := RttiContexto.GetType(classe.ClassType);

  for RttiProp in RttiTipo.GetProperties do
    if (RttiProp.GetAttribute(ASomenteLeitura) = nil) and (RttiProp.GetAttribute
      (ADetalhe) = nil) and (RttiProp.GetAttribute(ACampo) <> nil) then
      s.Add(ACampo(RttiProp.GetAttribute(ACampo)).NomeDB);

  s.StrictDelimiter := True;
  s.Delimiter := ',';
  Result := s.DelimitedText;
end;

function TPersistenciaClass.getCampoValor(classe: TObject): string;
var
  s: TStringList;
  f: TFormatSettings;
  campo, valor: string;
begin
  s := TStringList.Create;

  RttiTipo := RttiContexto.GetType(classe.ClassType);

  for RttiProp in RttiTipo.GetProperties do
  begin
    if (RttiProp.GetAttribute(ASomenteLeitura) = nil) and (RttiProp.GetAttribute
      (ADetalhe) = nil) then
    begin
      campo := ACampo(RttiProp.GetAttribute(ACampo)).NomeDB;
      valor := getValueFromProp(RttiProp.GetValue(classe));
      s.Add(campo + '=' + valor);
    end;
  end;

  s.StrictDelimiter := True;
  s.Delimiter := ',';
  Result := s.DelimitedText;
end;

function TPersistenciaClass.getFKField(classe: TObject): TObjectList<TRttiProperty>;
begin
  RttiTipo := RttiContexto.GetType(classe.ClassType);
  Result := nil;

  for RttiProp in RttiTipo.GetProperties do
  begin
    if RttiProp.GetAttribute(AFK) <> nil then
      Result.Add(RttiProp)
  end;
  Exit;
end;

function TPersistenciaClass.getIndiceFK(classe: TObject): TDictionary<string, string>;
begin
  Result := TDictionary<string, string>.Create;
  for RttiProp in getFKField(classe) do
    Result.Add(ACampo(RttiProp.GetAttribute(ACampo)).NomeDB, RttiProp.GetValue(classe).ToString);
end;

function TPersistenciaClass.getIndicePK(classe: TObject): string;
begin
  RttiProp := GetPKField(classe);
  Result := ACampo(RttiProp.GetAttribute(ACampo)).NomeDB + '=' + RttiProp.GetValue(classe).ToString;
end;

function TPersistenciaClass.getNomeTabela(classe: TObject): string;
begin
  try
    RttiTipo := RttiContexto.GetType(classe.ClassType);
    Result := ATabela(RttiTipo.getAttribute(ATabela)).NomeTabela;
  except
    raise EPersistenciaClass.Create('Erro ao tentar pegar nome da tabela.' + #13
      + 'Verifique a classe : ' + classe.ClassName + '.');
  end;
end;

procedure TPersistenciaClass.GetValoresFromDataset(Dataset: TDataSet; classe: TObject);
var
  Value: TValue;
  nomeField: string;
begin
  RttiTipo := RttiContexto.GetType(classe.classType);

  try
    for RttiProp in RttiTipo.GetProperties do
    begin
      if (RttiProp.GetAttribute(ASomenteLeitura) = nil) and (RttiProp.GetAttribute
        (ADetalhe) = nil) and (RttiProp.GetAttribute(ACampo) <> nil) and (RttiProp.GetAttribute
        (AFK) = nil) then
      begin
        Atributo := RttiProp.GetAttribute(ACampo);
        nomeField := ACampo(Atributo).NomeDB;

        Value := RttiProp.GetValue(classe);
        case Value.Kind of
          tkUString:
            if RttiProp.GetAttribute(ALogico) <> nil then
              Value := GetLogico(Dataset.FieldByName(nomeField).AsString)
            else
              Value := Dataset.FieldByName(nomeField).AsString;
          tkInteger:
            Value := Dataset.FieldByName(nomeField).AsInteger;
          tkFloat:
            begin
              if (Value.TypeInfo = TypeInfo(Real)) or (Value.TypeInfo = TypeInfo(Double)) then
                Value := Dataset.FieldByName(nomeField).AsExtended;

              if Value.TypeInfo = TypeInfo(TDate) then
                Value := Dataset.FieldByName(nomeField).AsDateTime;

              if Value.TypeInfo = TypeInfo(TTime) then
                Value := Dataset.FieldByName(nomeField).AsExtended;
            end;
        end;

        RttiProp.SetValue(classe, Value);
      end;
    end;
  except
    on E: Exception do
      ShowMessage('Erro: ' + E.Message + ' - ' + E.ClassName + #13 + nomeField +
        ' - ' + classe.ClassName);
  end;
end;

function TPersistenciaClass.GetValueFK(classe: TObject): string;
var
  ValueFK: TValue;
begin
  ValueFK := GetPKField(RttiProp.GetValue(classe).AsObject);

  if TRttiType(ValueFK.AsObject).isTabela then
    GetValueFK(ValueFK.AsObject)
  else
    Result := getValueFromProp(ValueFK);
end;

end.

