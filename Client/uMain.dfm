object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 378
  ClientWidth = 469
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 14
    Top = 14
    Width = 10
    Height = 13
    Caption = 'IP'
  end
  object Label2: TLabel
    Left = 14
    Top = 62
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Edt_IP: TEdit
    Left = 14
    Top = 33
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '127.0.0.1'
  end
  object Edit_Port: TEdit
    Left = 14
    Top = 81
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '3306'
  end
  object GroupBox1: TGroupBox
    Left = 148
    Top = 14
    Width = 271
    Height = 119
    Caption = 'GroupBox1'
    TabOrder = 2
    object Label3: TLabel
      Left = 8
      Top = 44
      Width = 39
      Height = 13
      Caption = 'Address'
    end
    object Label4: TLabel
      Left = 143
      Top = 48
      Width = 22
      Height = 13
      Caption = 'Host'
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 21
      Width = 97
      Height = 17
      Caption = 'Connected'
      Enabled = False
      TabOrder = 0
    end
    object Edt_Address: TEdit
      Left = 7
      Top = 63
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 1
      Text = 'Edt_Address'
    end
    object Edt_Host: TEdit
      Left = 143
      Top = 63
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 2
      Text = 'Edit3'
    end
  end
  object Button2: TButton
    Left = 340
    Top = 147
    Width = 75
    Height = 25
    Caption = 'Send'
    Enabled = False
    TabOrder = 3
    OnClick = Button2Click
  end
  object Edit_Message: TEdit
    Left = 14
    Top = 149
    Width = 317
    Height = 21
    Enabled = False
    TabOrder = 4
  end
  object Mem_Dialog: TMemo
    Left = 14
    Top = 180
    Width = 398
    Height = 179
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object Button3: TButton
    Left = 14
    Top = 108
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 6
    OnClick = Button3Click
  end
  object ClientSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnect = ClientSocketConnect
    OnDisconnect = ClientSocketDisconnect
    OnRead = ClientSocketRead
    OnError = ClientSocketError
    Left = 216
    Top = 256
  end
end
