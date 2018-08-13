unit UnitClass.Helper.Form;

interface

uses
  Vcl.Forms;

type
  TFormMelhorado = class helper for TForm
  public
    procedure ClearDataComponents;
  end;

implementation

uses
  Vcl.StdCtrls, Vcl.ComCtrls, System.SysUtils;

{ TFormMelhorado }

procedure TFormMelhorado.ClearDataComponents;
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I] is TEdit then
      TEdit(Components[I]).text := '';

    if Components[I] is TComboBox then
      TComboBox(Components[I]).Text := '';

    if Components[I] is TDateTimePicker then
      TDateTimePicker(Components[I]).Date := Now;
  end;
end;

end.

