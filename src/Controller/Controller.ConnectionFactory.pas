unit Controller.ConnectionFactory;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Phys.FB, FireDAC.Stan.Error,
  FireDAC.Stan.Async, FireDAC.VCLUI.Wait, FireDAC.DApt;

type
  TConnection = class
  private
    class var
      FDConnection: TFDConnection;
    class var
      FDTransaction: TFDTransaction;
  public
    class function GetConnection: TFDConnection;
  end;

implementation

uses
  System.Win.Registry, Winapi.Windows, Utils.Directory;

{ TConnection }

class function TConnection.GetConnection: TFDConnection;
begin
  FDConnection := TFDConnection.Create(nil);
  FDTransaction := TFDTransaction.Create(nil);
  with FDConnection do
  begin
    with FDConnection.Params do
    begin
      DriverID := 'FB';
      Database := GetDiretorioProjeto + '\DB\RTTI.fdb';
      UserName := 'SYSDBA';
      Password := 'masterkey';
    end;
    Transaction := FDTransaction;
    Connected := True;
  end;
  Result := FDConnection;
end;

end.

