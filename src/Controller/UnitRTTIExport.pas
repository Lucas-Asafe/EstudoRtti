unit UnitRTTIExport;

interface

uses
  RTTI, SysUtils, generics.collections, Classes, System.IOUtils, UnitClass.Helper.RTTI,
  UnitClass.CustomAttributes;

type
  TExport = class
  public
    class procedure exportarLista<T: class, constructor>(Lista: TList<T>);
  end;

implementation

uses
  System.TypInfo, Utils.Directory;

{ TExport }

class procedure TExport.exportarLista<T>(Lista: TList<T>);
var
  objeto: TObject;
  rttiTipo: TRttiType;
  rttiProp: TRttiProperty;
  atributo: AFormato;
  value: TValue;
  rel: TStringList;
  line: TStringBuilder;
begin
  rel := TStringList.Create;
  line := TStringBuilder.Create;
  objeto := T.create;
  rttiTipo := TRttiContext.Create.GetType(objeto.classType);

  for objeto in Lista do
  begin
    line.Clear;
    for rttiProp in rttiTipo.GetProperties do
    begin
      atributo := rttiProp.getAttribute(AFormato) as AFormato;
      value := rttiProp.GetValue(objeto);

      case value.Kind of
        tkUString:
          line.Append(value.ToString.PadRight(atributo.Tamanho));
        tkInteger:
          line.Append(value.ToString.PadLeft(atributo.Tamanho, '0'));
        tkFloat:
          begin
            if value.TypeInfo = TypeInfo(real) then
              line.Append(FormatFloat(atributo.getMascaraNumerica, value.AsExtended));

            if value.TypeInfo = TypeInfo(TDate) then
              line.Append(FormatDateTime(atributo.Mascara, value.AsExtended));
          end;
      end;
    end;
    rel.Add(line.ToString);
  end;
  rel.SaveToFile(GetDiretorioProjeto + '\report\rel.txt');
end;

end.

