program ProjectRTTI;

uses
  Vcl.Forms,
  UnitBase.Frm in 'Base\UnitBase.Frm.pas' {FormBase},
  UnitClass.CustomAttributes in 'Class\UnitClass.CustomAttributes.pas',
  UnitClass.FactoryClass in 'Class\UnitClass.FactoryClass.pas',
  UnitClass.FactoryForm in 'Class\UnitClass.FactoryForm.pas',
  UnitClass.PersistenciaClass in 'Class\UnitClass.PersistenciaClass.pas',
  UnitClass.Validador in 'Class\UnitClass.Validador.pas',
  UnitDataModule in 'Controller\UnitDataModule.pas' {DM: TDataModule},
  UnitRTTIExport in 'Controller\UnitRTTIExport.pas',
  UnitCliente in 'Model\UnitCliente.pas',
  UnitCliente.Frm in 'View\UnitCliente.Frm.pas' {frmCadastroCliente},
  Controller.ConnectionFactory in 'Controller\Controller.ConnectionFactory.pas',
  Utils.Str in 'Utils\Utils.Str.pas',
  UnitClass.Helper.RTTI in 'Class\Helper\UnitClass.Helper.RTTI.pas',
  Utils.Directory in 'Utils\Utils.Directory.pas',
  UnitTelefone in 'Model\UnitTelefone.pas',
  UnitClass.Helper.StringGrid in 'Class\Helper\UnitClass.Helper.StringGrid.pas',
  UnitClass.Helper.Form in 'Class\Helper\UnitClass.Helper.Form.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmCadastroCliente, frmCadastroCliente);
  Application.Run;
end.
