unit UnitClass.FactoryForm;

interface

uses
  Vcl.Forms, Rtti, System.Classes, System.SysUtils, Vcl.ComCtrls;

type
  TFactoryForm = class
  public
    class procedure setFormFromClasse(Form: TForm; classe: TObject);
  end;

implementation

uses
  Vcl.StdCtrls, UnitClass.Helper.Form;

{ TFactoryForm }

var
  RttiContexto: TRttiContext;
  RttiTipo: TRttiType;
  RttiProp: TRttiProperty;

class procedure TFactoryForm.setFormFromClasse(Form: TForm; classe: TObject);
var
  Componente: TComponent;
  I: Integer;
begin
  if not Assigned(classe) then
  begin
    Form.ClearDataComponents;
    Exit;
  end;

  RttiContexto := TRttiContext.Create;
  RttiTipo := RttiContexto.GetType(classe.ClassType);

  for RttiProp in RttiTipo.GetProperties do
  begin
    for I := 0 to Form.ComponentCount - 1 do
    begin
      Componente := Form.Components[I];
      if string(Componente.Name).contains(RttiProp.Name) then
      begin
        if Componente is TEdit then
          TEdit(Componente).text := RttiProp.GetValue(classe).toString;

        if Componente is TComboBox then
          TComboBox(Componente).Text := RttiProp.GetValue(classe).toString;

        if Componente is TDateTimePicker then
          TDateTimePicker(Componente).Date := RttiProp.GetValue(classe).AsExtended;
      end;
    end;
  end;
end;

end.

