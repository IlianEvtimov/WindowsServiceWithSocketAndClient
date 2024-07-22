﻿unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, Vcl.StdCtrls, System.Win.ScktComp, System.IniFiles, System.IOUtils;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edt_IP: TEdit;
    Edit_Port: TEdit;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    Edt_Address: TEdit;
    Edt_Host: TEdit;
    Button2: TButton;
    Edit_Message: TEdit;
    Mem_Dialog: TMemo;
    ClientSocket: TClientSocket;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure ClientSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure FormCreate(Sender: TObject);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button2Click(Sender: TObject);
begin
  ClientSocket.Socket.SendText(UTF8Encode(Edit_Message.Text));
  Mem_Dialog.Lines.Add('Me: ' + Edit_Message.Text);
  Edit_Message.Text := '';
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  ClientSocket.Active := False;
  ClientSocket.Host := Edt_IP.Text;
  ClientSocket.Port := StrToInt(Edit_Port.Text);
  ClientSocket.Active := True;
end;

procedure TForm2.ClientSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  CheckBox1.Checked := Socket.Connected;
  Edt_Address.Text  := Socket.LocalAddress;
  Edt_Host.Text     := Socket.LocalHost;
  Mem_Dialog.Clear;
end;

procedure TForm2.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  CheckBox1.Checked := Socket.Connected;
end;

procedure TForm2.ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
   if ErrorCode = 10061 then
  begin
    ShowMessage('Cannot connect to the server. The server might not be running.');
    ErrorCode := 0;
  end
  else
  begin
    ShowMessage('Socket error: ' + IntToStr(ErrorCode));
    ErrorCode := 0;
  end;
end;

procedure TForm2.ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
var
  ReceivedText: string;
begin
//  Mem_Dialog.Lines.Add(string(ClientSocket.Socket.ReceiveText));
  ReceivedText := string(ClientSocket.Socket.ReceiveText);
  TThread.Queue(nil,
    procedure
    begin
      Mem_Dialog.Lines.Add(ReceivedText);
    end
  );
end;

function BacktrackDirectories(Path: string; Levels: Integer): string;
var
  i: Integer;
begin
  Result := Path;
  for i := 1 to Levels do
  begin
    Result := TPath.GetDirectoryName(Result);
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  LSettings : TIniFile;
  path      : string;
begin
  path := BacktrackDirectories(ExtractFilePath(Application.ExeName), 4);
  LSettings := TIniFile.Create(path + PathDelim + 'ServerSettings.Ini');

  try
    Edit_Port.Text := LSettings.ReadString('Server', 'Port', '');

   if Edit_Port.Text <> '' then
     Button3Click(nil);

  finally
    FreeAndNil(LSettings);
  end;


end;

end.
