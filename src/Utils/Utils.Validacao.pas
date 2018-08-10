unit Utils.Validacao;

interface

uses
    UnitClass.CustomAttributes,
    UnitClass.Helper.RTTI,
    System.Rtti;

function IsGenericTObjectList(const obj: TObject): Boolean;

function IsDetailList(const PRttiProp: TRttiProperty; const PClasse: TObject): Boolean;

implementation

uses
    Vcl.Dialogs,
    System.SysUtils;

function IsGenericTObjectList(const obj: TObject): Boolean;
begin
    Result := obj.ClassName.contains('TObjectList');
    if not Result then
        ShowMessage('O objeto ' + obj.ClassName.QuotedString + ' que não é uma lista.');
end;

function IsDetailList(const PRttiProp: TRttiProperty; const PClasse: TObject): Boolean;
begin
    Result := (PRttiProp.getAttribute(ADetalhe) <> nil) and (PRttiProp.GetValue(PClasse).Kind
        = tkClass) and (IsGenericTObjectList(PRttiProp.GetValue(PClasse).AsObject));
end;

end.

