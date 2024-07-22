unit BackgroundThreadUnit;

interface

uses
  System.Classes;

type
  TBackgroundThread = class(TThread)
  private
    FPaused: Boolean;
    // increase capabilities here
    // FTerminated: Boolean;
    // FOnTerminate: TNotifyEvent;
  protected
    procedure Execute; override;
  public
    procedure Pause;
    procedure Continue;
    // procedure Terminate;
    // property OnTerminate: TNotifyEvent read FOnTerminate write FOnTerminate;
  end;

implementation

uses
  System.SysUtils, System.IOUtils, ServiceUnit;

procedure TBackgroundThread.Continue;
begin
  FPaused := False;
end;

  // process something here
procedure TBackgroundThread.Execute;
var
  LogFile: TextFile;
begin
  try
    FPaused := False;
    Randomize;
    while not Terminated do
    begin
      if not FPaused then
      begin
        if ServerSocket.Socket.ActiveConnections > 0 then
          ServerSocket.Socket.Connections[0].SendText(UTF8Encode(IntToStr(Random(2000))));
      end;
      TThread.Sleep(5000);
    end;
  finally
    CloseFile(LogFile);
  end;
end;

procedure TBackgroundThread.Pause;
begin
  FPaused := True;
end;

end.

