unit Helper.FDManager;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Intf, System.SysUtils;

type
  TFDCustomManagerHelper = class helper for TFDCustomManager
    function CloneConnection(oDef: IFDStanConnectionDef;
      const NewConnDefName: string): IFDStanConnectionDef;
    function CloneConnectionByDefName(const ConnDefName: string;
      const NewConnDefName: string): IFDStanConnectionDef;
  end;

implementation

{ TFDCustomManagerHelper }

function TFDCustomManagerHelper.CloneConnection(oDef: IFDStanConnectionDef;
  const NewConnDefName: string): IFDStanConnectionDef;
begin
  Result := FDManager.ConnectionDefs.AddConnectionDef;
  Result.Name := NewConnDefName;
  Result.Params.AddStrings(oDef.Params);
end;

function TFDCustomManagerHelper.CloneConnectionByDefName(const ConnDefName,
  NewConnDefName: string): IFDStanConnectionDef;
var
  oDef: IFDStanConnectionDef;
begin
  oDef := FDManager.ConnectionDefs.ConnectionDefByName(ConnDefName);
  if Assigned(oDef) then
    Result := CloneConnection(oDef,NewConnDefName)
  else
    raise EAbort.Create('Error Message');
end;

end.
