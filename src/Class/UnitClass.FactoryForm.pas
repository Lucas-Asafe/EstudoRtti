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
  Vcl.StdCtrls;

{ TFactoryForm }

var
  RttiContexto : TRttiContext;
  RttiTipo     : TRttiType;
  RttiProp     : TRttiProperty;
  Value        : TValue;
  Componente    : TComponent;
  I: integer;

class procedure TFactoryForm.setFormFromClasse(Form: TForm; classe: TObject);
begin
  RttiContexto:=TRttiContext.Create;
  RttiTipo    :=RttiContexto.GetType(Classe.ClassType);

  for RttiProp in RttiTipo.GetProperties do
  begin
    for I:=0 to Form.ComponentCount-1 do
    begin
      componente:=Form.Components[I];
      if String(componente.Name).Contains(RttiProp.Name) then
      begin
        if Componente is TEdit then
          (componente as TEdit).text:=RttiProp.GetValue(classe).ToString;

        if Componente is TComboBox then
          (Componente as TComboBox).Text:= RttiProp.GetValue(classe).ToString;

        if Componente is TDateTimePicker then
          (Componente as TDateTimePicker).Date:= RttiProp.GetValue(classe).AsExtended;
      end;
    end;
  end;
end;

end.
