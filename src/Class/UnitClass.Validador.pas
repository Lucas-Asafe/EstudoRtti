unit UnitClass.Validador;

interface

uses
  System.Classes, RTTI, UnitClass.CustomAttributes, System.SysUtils, UnitClass.Helper.RTTI;

type
  TValidador = class
  public
    class procedure ValidarClasse(classe: TObject; e: TStrings); static;
    class function isRttiClasse(classe: TObject): Boolean; static;
  end;

implementation

var
  contexto: TRttiContext;
  tipo: TRttiType;
  propriedade: TRttiProperty;
  atributo: TCustomAttribute;

class procedure TValidador.ValidarClasse(classe: TObject; e: TStrings);
begin
  e.Clear;
  contexto := TRttiContext.Create;
  tipo := contexto.GetType(classe.ClassType);

  for propriedade in tipo.GetProperties do
  begin

    if propriedade.GetAttribute(ANotNull) <> nil then
    begin
      if (propriedade.GetValue(classe).toString = '') then
        e.Add('O Campo ' + propriedade.Name + ' Não foi informado!');

      if (propriedade.GetValue(classe).toString = '0') then
        e.Add('O Campo ' + propriedade.Name + ' Não pode ser Zero!');

      if (propriedade.GetValue(classe).toString = '30/12/1899') then
        e.Add('É obrigatório informar uma data válida para ' + propriedade.Name);
    end;
  end;
end;

class function TValidador.isRttiClasse(classe: TObject): Boolean;
begin
  contexto := TRttiContext.Create;
  tipo := contexto.GetType(classe.ClassType);
  Exit(tipo.GetAttributes <> nil);
end;

end.

