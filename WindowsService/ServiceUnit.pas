﻿unit ServiceUnit;

interface

uses
  Winapi.Windows
, Winapi.Messages
, System.SysUtils
, System.Classes
, Vcl.Graphics
, Vcl.Controls
, Vcl.SvcMgr
, Vcl.Dialogs
, System.IniFiles
, Winapi.ShellAPI
, System.Win.ScktComp
, Vcl.Forms
, System.IOUtils
, BackgroundThreadUnit
, System.Win.Registry, Vcl.ExtCtrls;

type
  TService1 = class(TService)
//    procedure ServiceExecute(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServiceAfterInstall(Sender: TService);

  private
    { Private declarations }
    FBackgroundThread: TBackgroundThread;
    FSettings : TIniFile;

    procedure createSocketServer;
    function BacktrackDirectories(Path: string; Levels: Integer): string;
  public

    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

{$R *.dfm}

var
  MyService: TService1;
  LogFile: TextFile;
  ServerSocket : TServerSocket;

implementation
uses
  uMainTest;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  MyService.Controller(CtrlCode);
end;


//procedure TService1.ServiceExecute(Sender: TService);
//begin
//  while not Terminated do
//  begin
//    ServiceThread.ProcessRequests(False);
//    Sleep(5000);
//  end;
//end;

procedure TService1.createSocketServer;
var
  port : Integer;
  path : String;
begin
  if ServerSocket = nil then
    ServerSocket := TServerSocket.Create(nil);

  ServerSocket.Active := False;
  {
    Set the TServerSocket.Port property to 0.
    The OS will assign the first available port it finds.
    You can then read the TServerSocket.Socket.LocalPort property after the server is active to find out which port was actually asssigned.
  }
  ServerSocket.Port   := 0;
  ServerSocket.Active := True;

  port := ServerSocket.Socket.LocalPort;

  path := BacktrackDirectories(ExtractFilePath(Application.exename), 4);
  FSettings := TIniFile.Create(path + PathDelim + 'ServerSettings.Ini');

  try
    AssignFile(LogFile, path + PathDelim + 'logfile.txt');
    Rewrite(LogFile);

    FSettings.WriteString('Server', 'Port', IntToStr(port));
  finally
    FreeAndNil(FSettings);
  end;
end;

function TService1.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

function TService1.BacktrackDirectories(Path: string; Levels: Integer): string;
var
  i: Integer;
begin
  Result := Path;
  for i := 1 to Levels do
  begin
    Result := TPath.GetDirectoryName(Result);
  end;
end;

procedure TService1.ServiceContinue(Sender: TService;
  var Continued: Boolean);
begin
  FBackgroundThread.Continue;
  Continued := True;
end;

procedure TService1.ServiceAfterInstall(Sender: TService);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SYSTEM\CurrentControlSet\Services\' + name, false) then
    begin
      Reg.WriteString('Description', 'Blogs.Embarcadero.com');
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TService1.ServicePause(Sender: TService; var Paused: Boolean);
begin
  FBackgroundThread.Pause;
  Paused := True;
end;

procedure TService1.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  FBackgroundThread.Terminate;
  FBackgroundThread.WaitFor;
  FreeAndNil(FBackgroundThread);
  FreeAndNil(ServerSocket);
  Stopped := True;
end;

procedure TService1.ServiceStart(Sender: TService; var Started: Boolean);
begin
  try
    createSocketServer;
    FBackgroundThread := TBackgroundThread.Create(True);
    FBackgroundThread.Start;
    Started := True;
  except
    on E: Exception do
    begin
      // Логване на грешката
      WriteLn(LogFile, 'Error starting service: ' + E.Message);
      Started := False;
    end;
  end;
  CloseFile(LogFile);
end;



end.
