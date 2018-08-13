unit UnitClass.Helper.RTTI;

interface

uses
  RTTI, UnitClass.CustomAttributes;

type
  TCustomAttributeClass = class of TCustomAttribute;

  TRttiPropertyMelhorado = class helper for TRttiProperty
  public
    function GetAttribute(CustomAttribute: TCustomAttributeClass): TCustomAttribute;
    function GetFKValue(classe: TObject): TValue;
    function isCampoSimples: Boolean;
    function isCampo: Boolean;
    function isSomenteLeitura: Boolean;
    function isDetalhe: Boolean;
    function isChaveEstrangeira: Boolean;
    function isChavePrimaria: Boolean;
  end;

  TRttiTypeMelhorado = class helper for TRttiType
  public
    function GetAttribute(CustomAttribute: TCustomAttributeClass): TCustomAttribute;
    function GetPropertyFromAttribute(CustomAttribute: TCustomAttributeClass): TRttiProperty;
    function GetPKField: TRttiProperty;
    function isTabela: Boolean;
  end;

implementation

{ TRttiPropertyMelhorado }

function TRttiPropertyMelhorado.GetAttribute(CustomAttribute:
  TCustomAttributeClass): TCustomAttribute;
var
  atributo: TCustomAttribute;
begin
  Result := nil;
  for atributo in GetAttributes do
  begin
    if atributo is CustomAttribute then
    begin
      Exit(atributo);
    end;
  end;
end;

function TRttiPropertyMelhorado.GetFKValue(classe: TObject): TValue;
var
  ValueFK: TValue;
begin
  ValueFK := TRttiContext.Create.GetType(GetValue(classe).AsClass).GetPKField;

  if TRttiType(ValueFK.AsObject).isTabela then
    GetFKValue(ValueFK.AsObject)
  else
    Result := ValueFK;
end;

function TRttiPropertyMelhorado.isCampo: Boolean;
begin
  Result := GetAttribute(ACampo) <> nil;
end;

function TRttiPropertyMelhorado.isCampoSimples: Boolean;
begin
  Result := False;

  if (isDetalhe) then
    Exit;

  if (isSomenteLeitura) then
    Exit;

  if (isChaveEstrangeira) then
    Exit;

  if (isCampo) then
    Result := True;
end;

function TRttiPropertyMelhorado.isChaveEstrangeira: Boolean;
begin
  Result := GetAttribute(AFK) <> nil;
end;

function TRttiPropertyMelhorado.isChavePrimaria: Boolean;
begin
  Result := GetAttribute(APK) <> nil;
end;

function TRttiPropertyMelhorado.isDetalhe: Boolean;
begin
  Result := GetAttribute(ADetalhe) <> nil;
end;

function TRttiPropertyMelhorado.isSomenteLeitura: Boolean;
begin
  Result := GetAttribute(ASomenteLeitura) <> nil;
end;

{ TRttiTypeMelhorado }

function TRttiTypeMelhorado.GetAttribute(CustomAttribute: TCustomAttributeClass): TCustomAttribute;
var
  atributo: TCustomAttribute;
begin
  Result := nil;
  for atributo in GetAttributes do
  begin
    if atributo is CustomAttribute then
    begin
      Exit(atributo);
    end;
  end;
end;

function TRttiTypeMelhorado.GetPKField: TRttiProperty;
begin
  Result := GetPropertyFromAttribute(APK);
end;

function TRttiTypeMelhorado.GetPropertyFromAttribute(CustomAttribute:
  TCustomAttributeClass): TRttiProperty;
var
  RttiProp: TRttiProperty;
begin
  for RttiProp in GetProperties do
  begin
    if RttiProp.GetAttribute(CustomAttribute) <> nil then
    begin
      Exit(RttiProp);
    end;
  end;
end;

function TRttiTypeMelhorado.isTabela: Boolean;
begin
  Result := GetAttribute(ATabela) <> nil;
end;

end.

