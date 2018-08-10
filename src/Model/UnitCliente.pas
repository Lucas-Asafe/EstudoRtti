unit UnitCliente;

interface

uses
  UnitClass.CustomAttributes, System.Generics.Collections, Data.DB;

type
  [ATabela('CLNT')]
  TCliente = class
  private
    FCodigo: Integer;
    FNome: string;
    FDocumento: string;
    FEndereco: string;
    FSexo: string;
    FDataNascimento: TDate;
    FDataCadastro: TDate;
    FCredito: Real;
  public
    [ACampo('ID'),
    ANotNull,
    APK,
    AFormato(3)]
    property Codigo: Integer read FCodigo write FCodigo;
    [ACampo('NOME'),
    ANotNull,
    AFormato(40)]
    property Nome: string read FNome write FNome;
    [ACampo('DOC'),
    ANotNull,
    AFormato(14)]
    property Documento: string read FDocumento write FDocumento;
    [ACampo('LOGRADOURO'),
    ANotNull,
    AFormato(60)]
    property Endereco: string read FEndereco write FEndereco;
    [ACampo('SEXO'),
    AFormato(10)]
    property Sexo: string read FSexo write FSexo;
    [ACampo('DTNASC'),
    ANotNull,
    AFormato('dd-mm-yyyy')]
    property DataNascimento: TDate read FDataNascimento write FDataNascimento;
    [ACampo('DTCAD'),
    ANotNull,
    AFormato('yyyymmdd')]
    property DataCadastro: TDate read FDataCadastro write FDataCadastro;
    [ACampo('CREDITO'),
    AFormato(10, 2)]
    property Credito: Real read FCredito write FCredito;
  end;

  TClientes = TObjectList<TCliente>;

implementation

end.

