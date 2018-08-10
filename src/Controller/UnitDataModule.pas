unit UnitDataModule;

interface

uses
  System.SysUtils, Data.FMTBcd, Forms, Data.DB, Datasnap.DBClient, Datasnap.Provider,
  System.Classes, frxClass, UnitCliente, UnitClass.PersistenciaClass, RTTI;

type
  TDM = class(TDataModule)
    frxReport1: TfrxReport;
    frxUserDataSet1: TfrxUserDataSet;
    procedure frxUserDataSet1GetValue(const VarName: string; var Value: Variant);
  private
    FListCliente: TClientes;
  public
    procedure gerarRelatorio(Cliente: TClientes);
  end;

var
  DM: TDM;

implementation

uses
  Utils.Directory;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.frxUserDataSet1GetValue(const VarName: string; var Value: Variant);
var
  tipo: TRttiType;
  c: TCliente;
begin
  c := FListCliente.Items[frxUserDataSet1.RecNo];

  tipo := TRttiContext.Create.GetType(c.ClassType);
  Value := tipo.GetProperty(VarName).GetValue(c).ToString;
end;

procedure TDM.gerarRelatorio(Cliente: TClientes);
begin
  FListCliente := Cliente;

  frxReport1.Clear;
  frxReport1.LoadFromFile(GetDiretorioProjeto + '\report\rel.fr3');

  frxUserDataSet1.RangeEnd := reCount;
  frxUserDataSet1.RangeEndCount := FListCliente.Count;
  frxReport1.ShowReport;
end;

end.

