unit Utils.Directory;

interface

function GetDiretorioProjeto: string;

implementation

uses
  System.SysUtils, Vcl.Forms, System.IOUtils;

function GetDiretorioProjeto: string;
begin
  Result := TDirectory.GetParent(ExcludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)));
end;

end.

