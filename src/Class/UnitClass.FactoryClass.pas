unit UnitClass.FactoryClass;

interface

uses
  Vcl.Forms, DB, System.Classes, System.Rtti, sysUtils, Vcl.StdCtrls,
  JvDateTimePicker;

type
  TFactoryClass = class
  private
    class function getTextFromComponente(componente: TComponent): string;
  public
    class procedure getClasseDoForm(Formulario: TForm; classe: TObject);
  end;

implementation

uses
  Math;

var
  RttiContexto: TRttiContext;
  RttiTipo: TRttiType;
  RttiProp: TRttiProperty;
  Value: TValue;
  Componente: TComponent;
  I: integer;

class procedure TFactoryClass.getClasseDoForm(Formulario: TForm; classe: TObject);
begin
  RttiContexto := TRttiContext.Create;
  RttiTipo := RttiContexto.GetType(classe.ClassType);
  for RttiProp in RttiTipo.GetProperties do
  begin
    for I := 0 to Formulario.ComponentCount - 1 do
    begin
      componente := Formulario.Components[I];
      if string(componente.Name).contains(RttiProp.Name) then
      begin
        case RttiProp.GetValue(classe).Kind of
          tkUString:
            Value := getTextFromComponente(componente);
          tkInteger:
            Value := strToInt(getTextFromComponente(componente));
          tkFloat:
            Value := strToFloat(getTextFromComponente(componente));
        end;

        RttiProp.SetValue(classe, Value);
      end;
    end;
  end;
end;

class function TFactoryClass.getTextFromComponente(componente: TComponent): string;
begin
  if componente is TEdit then
  begin
    if (componente as TEdit).NumbersOnly and ((componente as TEdit).Text = '') then
      Exit('0')
    else
      Exit((componente as TEdit).Text);
  end;

  if componente is TComboBox then
    Exit((componente as TComboBox).Text);

  if componente is TJvDateTimePicker then
    Exit(floatToStr((componente as TJvDateTimePicker).Date));
end;

end.

