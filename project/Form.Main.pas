unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Phys.IBBase, FireDAC.Comp.DataSet, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef;

type
  TForm1 = class(TForm)
    Button1: TButton;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    Button2: TButton;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    ConnDefName1: string;
    ConnDefName2: string;
    { Private declarations }
    procedure RunTask(const AConnDefName: string);
    procedure SafeMessage(lbx: TListBox; const AMessage: string);
    procedure SafeRemoveListBox(lbx: TListBox);
    procedure TaskBody(lbx: TListBox; const AConnDefName: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  System.Threading, FireDAC.Phys.IBWrapper, Helper.FDManager;

procedure TForm1.FormCreate(Sender: TObject);
var
  oDef: IFDStanConnectionDef;
  newDef: IFDStanConnectionDef;
  ServerBadIPAddress: string;
begin
  ConnDefName1 := FDConnection1.ConnectionDefName;
  Button1.Caption := 'Connect with '+ConnDefName1;
  Button2.Caption := 'Connect with '+ConnDefName2;
  // ----------------------------------------------------------------
  // ----------------------------------------------------------------
  //
  // Clone base connection definition and
  // change its parameters to remove IP with bad IP address
  //
  // Error: Waiting for timeout is hanging other FireDAC threads
  //
  ConnDefName2 := ConnDefName1 + '_BadIP';
  newDef := FDManager.CloneConnectionByDefName(ConnDefName1,ConnDefName2);
  ServerBadIPAddress := '18.211.55.24';
  newDef.Params.Values['Protocol'] := 'TCPIP';
  newDef.Params.Values['Server'] := ServerBadIPAddress;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  RunTask(ConnDefName1);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  RunTask(ConnDefName2);
end;

procedure TForm1.SafeMessage(lbx: TListBox; const AMessage: string);
begin
  TThread.Synchronize(nil,
    procedure
    begin
      lbx.Items.Add(AMessage);
    end);
end;

procedure TForm1.SafeRemoveListBox(lbx: TListBox);
begin
  TThread.Synchronize(nil,
    procedure
    begin
      lbx.Parent := nil;
      lbx.Free;
    end);
end;

procedure TForm1.RunTask(const AConnDefName: string);
var
  aTask: ITask;
  lbx: TListBox;
begin
  lbx := TListBox.Create(self);
  lbx.Left := self.ClientWidth;
  lbx.AlignWithMargins := True;
  lbx.Align := alLeft;
  lbx.Width := ListBox1.Width;
  lbx.Parent := self;
  aTask := TTask.Create(
    procedure()
    begin
      TaskBody(lbx, AConnDefName);
      sleep(2000);
      SafeRemoveListBox(lbx);
    end);
  aTask.Start;
end;

procedure TForm1.TaskBody(lbx: TListBox; const AConnDefName: string);
var
  fdc: TFDCustomConnection;
  ds: TFDQuery;
begin
  SafeMessage(lbx, 'Connecting with :' + AConnDefName);
  fdc := TFDConnection.Create(nil);
  ds := TFDQuery.Create(nil);
  fdc.ConnectionDefName := AConnDefName;
  try
    fdc.Open;
    ds.Connection := fdc;
    ds.SQL.Text := 'SELECT * FROM {id Products}';
    ds.Open;
    while not ds.Eof do
    begin
      SafeMessage(lbx, ds.FieldByName('ProductName').AsString);
      sleep(10);
      ds.Next;
    end;
    SafeMessage(lbx, '**** Task finished');
  except
    on E: EFDDBEngineException do
    begin
      SafeMessage(lbx, 'Connection Error');
      SafeMessage(lbx, '**** Task finished with errors');
    end;
  end;
end;

end.
