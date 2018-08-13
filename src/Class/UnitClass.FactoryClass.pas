unit UnitClass.FactoryClass;

interface

uses
  Vcl.Forms, DB, System.Classes, System.Rtti, sysUtils, Vcl.StdCtrls,
  JvDateTimePicker, System.Generics.Collections, Vcl.Grids;

type
  TFactoryClass = class
  private
    class function getTextFromComponente(Componente: TComponent): string;
    class function GetListaFromComponente(Componente: TComponent): TObjectList<TObject>;
  public
    class procedure getClasseDoForm(Formulario: TForm; classe: TObject);
  end;

implementation

uses
  Math, UnitClass.Helper.RTTI;

class procedure TFactoryClass.getClasseDoForm(Formulario: TForm; classe: TObject);
var
  RttiContexto: TRttiContext;
  RttiTipo: TRttiType;
  RttiProp: TRttiProperty;
  Value: TValue;
  Componente: TComponent;
  I: Integer;
begin
  RttiContexto := TRttiContext.Create;
  RttiTipo := RttiContexto.GetType(classe.ClassType);
  for RttiProp in RttiTipo.GetProperties do
  begin
    for I := 0 to Formulario.ComponentCount - 1 do
    begin
      Componente := Formulario.Components[I];

      if not string(Componente.Name).contains(RttiProp.Name) then
        Continue;

      case RttiProp.GetValue(classe).Kind of
        tkUString:
          Value := getTextFromComponente(Componente);
        tkInteger:
          Value := StrToInt(getTextFromComponente(Componente));
        tkFloat:
          Value := StrToFloat(getTextFromComponente(Componente));
        tkClass:
          begin
            if RttiProp.isChaveEstrangeira then
            begin
//              Value := Get<TObjetoGenerico>(RttiProp.GetFKValue(classe).AsString);
            end
            else if RttiProp.isDetalhe then
            begin
              Value := GetListaFromComponente(Componente);
            end;
          end;
      end;

      RttiProp.SetValue(classe, Value);
    end;
  end;
end;

class function TFactoryClass.GetListaFromComponente(Componente: TComponent): TObjectList<TObject>;
var
  I: Integer;
begin
  Result := TObjectList<TObject>.Create;
  if Componente is TStringGrid then
  begin
    for I := 1 to TStringGrid(Componente).RowCount - 1 do
    begin
      Result.Add(TStringGrid(Componente).Objects[0, I]);
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
    Exit(FloatToStr((componente as TJvDateTimePicker).Date));
end;

end.

