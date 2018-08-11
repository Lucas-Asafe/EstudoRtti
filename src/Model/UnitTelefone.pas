unit UnitTelefone;

interface

uses
  UnitClass.CustomAttributes, System.Generics.Collections, Data.DB;

type
  [ATabela('TLFN')]
  TTelefone = class
  private
    FCodigo: Integer;
    FNumero: string;
  public
    [ACampo('CODIGO'),
    ANotNull,
    APK,
    AFormato(3)]
    property Codigo: Integer read FCodigo write FCodigo;
    [ACampo('NUMERO'),
    ANotNull,
    AFormato(20)]
    property Numero: string read FNumero write FNumero;
  end;

  TTelefones = TObjectList<TTelefone>;

implementation

end.

