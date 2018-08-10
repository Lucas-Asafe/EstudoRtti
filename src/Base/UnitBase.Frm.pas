unit UnitBase.Frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  JvExComCtrls, JvDateTimePicker, Data.DB, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TEditMode = (emInsert, emEdit, emNenhum);
  TFormBase = class(TForm)
    btnCancelar: TButton;
    btnNovo: TButton;
    Panel1: TPanel;
    btnSalvar: TButton;
    ListBox1: TListBox;
    btnExcluir: TButton;
    btnEditar: TButton;
    StringGrid: TStringGrid;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure clear;
    procedure status(editStatus: boolean; editModo: TEditMode);
  protected
    FEditMode: TEditMode;
  public
  end;

implementation

{$R *.dfm}

procedure TFormBase.btnCancelarClick(Sender: TObject);
begin
  status(false, emNenhum);
end;

procedure TFormBase.btnEditarClick(Sender: TObject);
begin
  status(true, emEdit);
end;

procedure TFormBase.btnExcluirClick(Sender: TObject);
begin
  status(false, emNenhum);
end;

procedure TFormBase.btnNovoClick(Sender: TObject);
begin
  status(true, emInsert);
  clear;
end;

procedure TFormBase.btnSalvarClick(Sender: TObject);
begin
  status(false, emNenhum);
end;

procedure TFormBase.clear;
var
  I: Integer;
begin
  for I := 0 to self.ComponentCount-1 do
  begin
    if Components[I] is TCustomEdit then
      (Components[I] as TCustomEdit).Clear;

    if Components[I] is TComboBox then
      (Components[I] as TComboBox).Text:='';

    if Components[I] is TDateTimePicker then
      (Components[I] as TDateTimePicker).Date:=0;
  end;
end;

procedure TFormBase.FormShow(Sender: TObject);
begin
  status(False,emNenhum);
end;

procedure TFormBase.status(editStatus: boolean; editModo: TEditMode);
begin
  FEditMode:= editModo;

  btnNovo.Enabled     := not editStatus;
  btnEditar.Enabled   := not editStatus;
  btnExcluir.Enabled  := not editStatus;
  btnSalvar.Enabled   := editStatus;
  btnCancelar.Enabled := editStatus;
end;

end.
