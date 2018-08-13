unit UnitCliente.Frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  JvExComCtrls, JvDateTimePicker, Data.DB, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  UnitDataModule, UnitClass.PersistenciaClass, UnitClass.Validador, UnitCliente,
  UnitClass.FactoryForm, UnitBase.Frm, UnitRTTIExport, UnitClass.Helper.StringGrid;

type
  TfrmCadastroCliente = class(TFormBase)
    edCodigo: TEdit;
    edNome: TEdit;
    edDocumento: TEdit;
    edEndereco: TEdit;
    edCredito: TEdit;
    cbSexo: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    dtDataNascimento: TJvDateTimePicker;
    dtDataCadastro: TJvDateTimePicker;
    Label9: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    grdTelefones: TStringGrid;
    lbl1: TLabel;
    edtTelefone: TEdit;
    btn1: TButton;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StringGridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure btnEditarClick(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    FClientes: TClientes;
    FPercistenceClass: TPersistenciaClass;
    procedure AtualizarGridCliente;
  public
    property Clientes: TClientes read FClientes write FClientes;
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

{$R *.dfm}

uses
  UnitClass.FactoryClass;

procedure TfrmCadastroCliente.AtualizarGridCliente;
begin
  StringGrid.SetObjectList<TCliente>(FClientes, ['ID', 'NOME', 'DOC']);

  if FClientes.Count > 0 then
    TFactoryForm.setFormFromClasse(Self, StringGrid.SelectedItem);
end;

procedure TfrmCadastroCliente.btn1Click(Sender: TObject);
begin
  grdTelefones.Cols[0].Add('0');
  grdTelefones.Cols[1].Add(edtTelefone.Text);
end;

procedure TfrmCadastroCliente.btnCancelarClick(Sender: TObject);
begin
  inherited;
  TFactoryForm.setFormFromClasse(Self, TCliente(StringGrid.SelectedItem));
end;

procedure TfrmCadastroCliente.btnEditarClick(Sender: TObject);
begin
  inherited;
  edNome.SetFocus;
  edNome.SelectAll;
end;

procedure TfrmCadastroCliente.btnExcluirClick(Sender: TObject);
var
  c: TCliente;
begin
  inherited;
  c := TCliente(StringGrid.SelectedItem);
  FPercistenceClass.delete(c);
  FClientes.Remove(c);
  AtualizarGridCliente;
end;

procedure TfrmCadastroCliente.btnNovoClick(Sender: TObject);
begin
  inherited;
  edCodigo.Text := '0';
  edCredito.Text := '0';
  edCodigo.SetFocus;
  edCodigo.SelectAll;
  StringGrid.RowCount := StringGrid.RowCount + 1;
  StringGrid.Row := StringGrid.RowCount - 1;
end;

procedure TfrmCadastroCliente.btnSalvarClick(Sender: TObject);
var
  C: TCliente;
begin
  ListBox1.Clear;
  C := TCliente.Create;

  TFactoryClass.getClasseDoForm(Self, C);
  TValidador.ValidarClasse(C, ListBox1.Items);

  if ListBox1.Items.Count > 0 then
    raise Exception.Create('Encontrado Erros de preenchimento!');

  case FEditMode of
    emInsert:
      FPercistenceClass.Insere(C);
    emEdit:
      FPercistenceClass.Altere(C);
  end;

  FPercistenceClass.GetLista<TCliente>(FClientes);
  AtualizarGridCliente;

  inherited;
end;

procedure TfrmCadastroCliente.Button1Click(Sender: TObject);
begin
  inherited;
  DM.gerarRelatorio(FClientes);
end;

procedure TfrmCadastroCliente.Button2Click(Sender: TObject);
begin
  inherited;
  TExport.exportarLista<TCliente>(FClientes);
end;

procedure TfrmCadastroCliente.Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    FPercistenceClass.GetLista<TCliente>(FClientes, Edit1.Text);
    AtualizarGridCliente();
  end;
end;

procedure TfrmCadastroCliente.FormCreate(Sender: TObject);
begin
  FClientes := TClientes.Create;
  FPercistenceClass := TPersistenciaClass.Create;
end;

procedure TfrmCadastroCliente.FormShow(Sender: TObject);
begin
  inherited;
  FPercistenceClass.GetLista<TCliente>(FClientes);
  AtualizarGridCliente;
end;

procedure TfrmCadastroCliente.StringGridSelectCell(Sender: TObject; ACol, ARow:
  Integer; var CanSelect: Boolean);
begin
  if StringGrid.SelectedItem <> nil then
    TFactoryForm.setFormFromClasse(Self, TCliente(StringGrid.SelectedItem));
end;

end.

