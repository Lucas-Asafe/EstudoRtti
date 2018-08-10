unit UnitClass.CustomAttributes;

interface

uses
  RTTI, System.TypInfo;

type
  ATabela = class(TCustomAttribute)
  private
    FNomeTabela: string;
  public
    constructor Create(PNomeTabela: string);
    property NomeTabela: string read FNomeTabela write FNomeTabela;
  end;

  ACampo = class(TCustomAttribute)
  private
    FNomeDB: string;
    FNomeDisplay: string;
  public
    constructor Create(PNomeDB: string; PNomeDisplay: string = '');
    property NomeDB: string read FNomeDB write FNomeDB;
    property NomeDisplay: string read FNomeDisplay write FNomeDisplay;
  end;

  APK = class(TCustomAttribute)
  end;

  AFK = class(TCustomAttribute)
  end;

  ANotNull = class(TCustomAttribute)
  end;

  ALogico = class(TCustomAttribute)
  end;

  ASomenteLeitura = class(TCustomAttribute)
  end;

  ADate = class(TCustomAttribute)
  end;

  ADetalhe = class(TCustomAttribute)
  private
    FAtualiza: Boolean;
  public
    constructor Create(PAtualiza: Boolean = True);
    property Atualiza: Boolean read FAtualiza write FAtualiza;
  end;

  AFormato = class(TCustomAttribute)
  private
    FTamanho: integer;
    FPrecisao: integer;
    FMascara: string;
  public
    property Tamanho: integer read FTamanho write FTamanho;
    property Precisao: integer read FPrecisao write FPrecisao;
    property Mascara: string read FMascara write FMascara;
    function getMascaraNumerica: string;
    constructor Create(PTamanho: integer; PPrecisao: integer = 0); overload;
    constructor Create(PMascara: string); overload;
  end;

implementation

uses
  System.StrUtils, System.SysUtils;

{ ACampo }

constructor ACampo.Create(PNomeDB: string; PNomeDisplay: string = '');
begin
  FNomeDB := PNomeDB;
  FNomeDisplay := IfThen(Trim(PNomeDisplay) = EmptyStr, PNomeDB, PNomeDisplay);
end;

{ ATabela }

constructor ATabela.Create(PNomeTabela: string);
begin
  FNomeTabela := PNomeTabela;
end;

{ AFormato }

constructor AFormato.Create(PTamanho, PPrecisao: integer);
begin
  FTamanho := PTamanho;
  FPrecisao := PPrecisao;
end;

constructor AFormato.Create(PMascara: string);
begin
  FMascara := PMascara;
end;

function AFormato.getMascaraNumerica: string;
var
  sTamanho, sPrecisao: string;
begin
  sTamanho := StringOfChar('0', FTamanho - FPrecisao);
  sPrecisao := StringOfChar('0', FPrecisao);

  Result := sTamanho + '.' + sPrecisao;
end;

{ ADetalhe }

constructor ADetalhe.Create(PAtualiza: Boolean = True);
begin
  FAtualiza := PAtualiza;
end;

end.

