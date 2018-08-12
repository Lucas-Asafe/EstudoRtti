unit UnitClass.Helper.StringGrid;

interface

uses
  Vcl.Grids, System.Rtti, UnitClass.CustomAttributes, UnitClass.Validador,
  UnitClass.PersistenciaClass, UnitClass.Helper.RTTI, System.Generics.Collections,
  System.Classes;

type
  TStringGridHelper = class helper for TStringGrid
  private
    procedure ClearCols;
    procedure ClearRows;
    procedure SetCols(PObjeto: TObject; PCols: array of string); overload;
    function IndexCol(PColumn: string): Integer;
  public
    procedure SetCols(PCols: array of string; PColsSize: array of Integer); overload;
    procedure Clear;
    procedure SetObjectList<T: class, constructor>(PObjectList: TObjectList<T>;
      PCols: array of string);
    function SelectedItem: TObject;
  end;

implementation

uses
  System.SysUtils, StrUtils, System.AnsiStrings;

{ TStringGridHelper }

procedure TStringGridHelper.Clear;
begin
  ClearCols;
  ClearCols;
end;

procedure TStringGridHelper.ClearCols;
var
  I: Integer;
begin
  for I := 0 to ColCount - 1 do
    Cols[I].Clear;
end;

procedure TStringGridHelper.ClearRows;
var
  I: Integer;
begin
  RowCount := 2;
  for I := 0 to RowCount do
    Rows[I].Clear;
end;

function TStringGridHelper.IndexCol(PColumn: string): Integer;
var
  I: Integer;
  LCols: array of string;
begin
  for I := 0 to ColCount - 1 do
    LCols[I] := Cols[I].Text;
  Result := AnsiIndexStr(UpperCase(PColumn), LCols);
end;

function TStringGridHelper.SelectedItem: TObject;
begin
  Result := Objects[0, Row];
end;

procedure TStringGridHelper.SetCols(PObjeto: TObject; PCols: array of string);
var
  I, Tamanho: Integer;
  RttiContexto: TRttiContext;
  RttiTipo: TRttiType;
  RttiProp: TRttiProperty;
  Atributo: TCustomAttribute;
begin
  FixedRows := 1;
  RttiContexto := TRttiContext.Create;
  RttiTipo := RttiContexto.GetType(PObjeto.ClassType);

  for RttiProp in RttiTipo.GetProperties do
  begin
    if (RttiProp.GetAttribute(ACampo) = nil) then
      Continue;

    Atributo := RttiProp.GetAttribute(ACampo);
    Tamanho := AFormato(RttiProp.GetAttribute(AFormato)).Tamanho;
    I := AnsiIndexStr(UpperCase(ACampo(Atributo).NomeDB), PCols);

    if (I < 0) then
      Continue;

    case Tamanho of
      0:
        ColWidths[I] := 90;
      10:
        ColWidths[I] := 75;
    else
      ColWidths[I] := Tamanho * 10;
    end;

    Cols[I].Add(ACampo(Atributo).NomeDisplay);
  end;
end;

procedure TStringGridHelper.SetCols(PCols: array of string; PColsSize: array of Integer);
var
  I: Integer;
begin
  for I := Low(PCols) to High(PCols) do
  begin
    ColWidths[I] := PColsSize[I];
    Cols[I].Add(PCols[I])
  end;
end;

procedure TStringGridHelper.SetObjectList<T>(PObjectList: TObjectList<T>; PCols: array of string);
var
  obj: TObject;
  I: Integer;
  RttiContexto: TRttiContext;
  RttiTipo: TRttiType;
  RttiProp: TRttiProperty;
begin
  RowCount := PObjectList.Count + 1;
  ClearCols;
  if RowCount < 1 then
    Exit;

  SetCols(PObjectList.First, PCols);

  for obj in PObjectList do
  begin
    if not TValidador.isRttiClasse(obj) then
      raise Exception.Create('Erro ao setar lista de objetos ' + obj.ClassName +
        ' no Grid.' + #13 + 'Verifique se a lista é de objetos rtti.');

    RttiTipo := RttiContexto.GetType(obj.ClassType);

    for RttiProp in RttiTipo.GetProperties do
    begin
      if (RttiProp.GetAttribute(ACampo) = nil) then
        Continue;

      I := AnsiIndexStr(UpperCase(ACampo(RttiProp.GetAttribute(ACampo)).NomeDB), PCols);

      if (I < 0) then
        Continue;

      if (I = 0) then
        Cols[I].AddObject(RttiProp.GetValue(obj).ToString, obj)
      else if AFormato(RttiProp.GetAttribute(AFormato)).Precisao = 0 then
        Cols[I].Add(RttiProp.GetValue(obj).ToString)
      else
        Cols[I].Add(FormatFloat('#,0.00', RttiProp.GetValue(obj).AsExtended));
    end;
  end;
end;

end.

