program ParallelFireDAC;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Form1},
  Helper.FDManager in 'Helper.FDManager.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
