unit UnitClass.Helper.RTTI;

interface

uses
  RTTI, UnitClass.CustomAttributes;

type
  TCustomAttributeClass = class of TCustomAttribute;

  TRttiPropertyMelhorado = class helper for TRttiProperty
  public
    function GetAttribute(CustomAttribute: TCustomAttributeClass): TCustomAttribute;
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
      Exit(atributo)
  end;
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
      Exit(atributo)
  end;

end;

function TRttiTypeMelhorado.isTabela: Boolean;
begin
  Result := GetAttribute(ATabela) <> nil;
end;

end.

