unit Utils.Str;

interface

function GetLogico(PStr: string): string;

implementation

uses
  System.StrUtils;

function GetLogico(PStr: string): string;
begin
  Result := IfThen(PStr = 'S', 'S', 'N');
end;

end.

