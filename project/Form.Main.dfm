object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 402
  ClientWidth = 590
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
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 182
    Height = 396
    Align = alLeft
    Caption = 'GroupBox1'
    Padding.Left = 3
    Padding.Top = 10
    Padding.Right = 3
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 8
      Top = 235
      Width = 166
      Height = 80
      Align = alTop
      Caption = 
        'Requires Firebird or Interbase  server and FireDAC demo databe (' +
        'IB_Demo or FB_Demo)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsItalic]
      ParentFont = False
      WordWrap = True
      ExplicitWidth = 118
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 8
      Top = 127
      Width = 166
      Height = 48
      Align = alTop
      Caption = 'OK: click Button1 and just after Button2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ExplicitWidth = 100
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 8
      Top = 181
      Width = 166
      Height = 48
      Align = alTop
      Caption = 'Threds hangs: Button2 and then Button1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ExplicitWidth = 101
    end
    object Button1: TButton
      AlignWithMargins = True
      Left = 8
      Top = 28
      Width = 166
      Height = 41
      Align = alTop
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
      ExplicitWidth = 118
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 8
      Top = 75
      Width = 166
      Height = 46
      Align = alTop
      Caption = 'Button2'
      TabOrder = 1
      OnClick = Button2Click
      ExplicitWidth = 118
    end
  end
  object ListBox1: TListBox
    AlignWithMargins = True
    Left = 191
    Top = 3
    Width = 178
    Height = 396
    Align = alLeft
    ItemHeight = 13
    TabOrder = 1
    Visible = False
    ExplicitLeft = 143
    ExplicitHeight = 330
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=IB_Demo')
    Left = 360
    Top = 16
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 360
    Top = 72
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 360
    Top = 120
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 360
    Top = 168
  end
end
