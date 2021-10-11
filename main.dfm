object MainPage: TMainPage
  Left = 223
  Top = 135
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'WebSite Downloader'
  ClientHeight = 474
  ClientWidth = 657
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label3: TLabel
    Left = 14
    Top = 432
    Width = 3
    Height = 16
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 0
    Width = 641
    Height = 137
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 136
      Height = 16
      Caption = 'Web page for analyse:'
    end
    object Label2: TLabel
      Left = 16
      Top = 71
      Width = 132
      Height = 16
      Caption = 'Download destination:'
    end
    object EditDestination: TEdit
      Left = 16
      Top = 96
      Width = 484
      Height = 25
      TabOrder = 1
    end
    object EditURL: TEdit
      Left = 16
      Top = 40
      Width = 481
      Height = 25
      TabOrder = 0
    end
    object ButDownload: TButton
      Left = 512
      Top = 64
      Width = 113
      Height = 25
      Caption = 'Start'
      TabOrder = 2
      OnClick = BtnDownLoadClick
    end
  end
  object Status: TStatusBar
    Left = 0
    Top = 457
    Width = 657
    Height = 17
    Panels = <>
    SimplePanel = True
    SimpleText = 'Pret'
    SizeGrip = False
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 144
    Width = 644
    Height = 305
    Caption = ' Links '
    TabOrder = 2
    object ListeLien: TListBox
      Left = 16
      Top = 24
      Width = 617
      Height = 121
      BevelInner = bvLowered
      BevelOuter = bvRaised
      Ctl3D = True
      ItemHeight = 16
      ParentCtl3D = False
      Sorted = True
      TabOrder = 0
    end
    object ListBox1: TListBox
      Left = 16
      Top = 152
      Width = 617
      Height = 121
      BevelInner = bvLowered
      BevelOuter = bvRaised
      Ctl3D = True
      ItemHeight = 16
      ParentCtl3D = False
      Sorted = True
      TabOrder = 1
    end
    object ProgressBar1: TProgressBar
      Left = 16
      Top = 280
      Width = 617
      Height = 17
      Smooth = True
      TabOrder = 2
    end
  end
  object MainMenu1: TMainMenu
    Left = 560
    Top = 24
    object File1: TMenuItem
      Caption = 'File'
      object Exit1: TMenuItem
        Caption = 'Exit'
      end
    end
    object Option1: TMenuItem
      Caption = 'Option'
      object Filter1: TMenuItem
        Caption = 'Filter'
        OnClick = Filter1Click
      end
    end
  end
end
