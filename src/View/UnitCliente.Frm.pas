unit UnitCliente.Frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  JvExComCtrls, JvDateTimePicker, Data.DB, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  UnitDataModule, UnitClass.PersistenciaClass, UnitClass.Validador, UnitCliente,
  UnitClass.FactoryForm, UnitBase.Frm, UnitRTTIExport;

type
  TForm3 = class(TFormBase)
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
  private
    FClientes: TClientes;
    FPercistenceClass: TPersistenciaClass;
    procedure atualizaGrid(selRow: Integer = 1);
    function getRegistroFromClienteList(LinhaGrid: Integer): TCliente;
  public
    property Clientes: TClientes read FClientes write FClientes;
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses
  UnitClass.FactoryClass;

procedure TForm3.atualizaGrid(selRow: Integer = 1);
var
  c: TCliente;
begin
  StringGrid.RowCount := FClientes.Count + 1;

  StringGrid.Cols[0].Clear;
  StringGrid.Cols[1].Clear;
  StringGrid.Cols[2].Clear;

  StringGrid.Rows[0].Add('Código');
  StringGrid.Rows[0].Add('Nome');
  StringGrid.Rows[0].Add('Documento');

  for c in FClientes do
  begin
    StringGrid.Cols[0].AddObject(c.Codigo.ToString, c);
    StringGrid.Cols[1].Add(c.Nome);
    StringGrid.Cols[2].Add(c.Documento);
  end;

  if selRow >= StringGrid.RowCount then
    selRow := StringGrid.RowCount - 1;

  StringGrid.Row := selRow;

  if FClientes.Count > 0 then
    TFactoryForm.setFormFromClasse(Self, getRegistroFromClienteList(selRow));

end;

function TForm3.getRegistroFromClienteList(LinhaGrid: Integer): TCliente;
begin
  Result := TCliente(StringGrid.Objects[0, LinhaGrid]);
end;

procedure TForm3.btnCancelarClick(Sender: TObject);
begin
  inherited;
  TFactoryForm.setFormFromClasse(Self, getRegistroFromClienteList(StringGrid.Row));
end;

procedure TForm3.btnEditarClick(Sender: TObject);
begin
  inherited;
  edNome.SetFocus;
  edNome.SelectAll;
end;

procedure TForm3.btnExcluirClick(Sender: TObject);
var
  c: TCliente;
  i: Integer;
begin
  inherited;
  i := StringGrid.Row;
  c := getRegistroFromClienteList(i);
  FPercistenceClass.delete(c);
  FClientes.Remove(c);
  atualizaGrid(i);
end;

procedure TForm3.btnNovoClick(Sender: TObject);
begin
  inherited;
  edCodigo.Text := '0';
  edCredito.Text := '0';
  edCodigo.SetFocus;
  edCodigo.SelectAll;
  StringGrid.RowCount := StringGrid.RowCount + 1;
  StringGrid.Row := StringGrid.RowCount - 1;
end;

procedure TForm3.btnSalvarClick(Sender: TObject);
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
  atualizaGrid(StringGrid.Row);

  inherited;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  inherited;
  DM.gerarRelatorio(FClientes);
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  inherited;
  TExport.exportarLista<TCliente>(FClientes);
end;

procedure TForm3.Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    FPercistenceClass.GetLista<TCliente>(FClientes, Edit1.Text);
    atualizaGrid();
  end;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  FClientes := TClientes.Create;
  FPercistenceClass := TPersistenciaClass.Create;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  inherited;
  FPercistenceClass.GetLista<TCliente>(FClientes);
  atualizaGrid;
end;

procedure TForm3.StringGridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if StringGrid.Objects[0, ARow] <> nil then
    TFactoryForm.setFormFromClasse(Self, getRegistroFromClienteList(ARow));
end;

end.

