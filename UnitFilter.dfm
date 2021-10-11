object FormFilter: TFormFilter
  Left = 586
  Top = 182
  BorderStyle = bsDialog
  Caption = 'Filter'
  ClientHeight = 369
  ClientWidth = 305
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 7
    Top = 4
    Width = 139
    Height = 237
    Caption = ' File Extention '
    TabOrder = 0
    object IncFileExt: TRadioButton
      Left = 20
      Top = 49
      Width = 98
      Height = 21
      Caption = 'Include Filter'
      TabOrder = 0
    end
    object ExcFileExt: TRadioButton
      Left = 20
      Top = 25
      Width = 98
      Height = 21
      Caption = 'Exclude filter'
      TabOrder = 1
    end
    object ListBox1: TListBox
      Left = 8
      Top = 82
      Width = 121
      Height = 143
      ItemHeight = 16
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 152
    Top = 4
    Width = 145
    Height = 85
    Caption = ' Host '
    TabOrder = 1
    object ExcHost: TRadioButton
      Left = 20
      Top = 25
      Width = 98
      Height = 21
      Caption = 'Exclude filter'
      TabOrder = 0
    end
    object IncHost: TRadioButton
      Left = 20
      Top = 49
      Width = 98
      Height = 21
      Caption = 'Include Filter'
      TabOrder = 1
    end
  end
  object GroupBox3: TGroupBox
    Left = 152
    Top = 96
    Width = 145
    Height = 113
    Caption = ' Sous Dossiers '
    TabOrder = 2
    object ExcChilds: TRadioButton
      Left = 20
      Top = 25
      Width = 98
      Height = 21
      Caption = 'Exclude filter'
      TabOrder = 0
    end
    object IncChilds: TRadioButton
      Left = 20
      Top = 49
      Width = 98
      Height = 21
      Caption = 'Include Filter'
      TabOrder = 1
    end
    object EditChilds: TEdit
      Left = 27
      Top = 79
      Width = 80
      Height = 24
      TabOrder = 2
      Text = '1'
    end
  end
  object GroupBox4: TGroupBox
    Left = 152
    Top = 216
    Width = 145
    Height = 113
    Caption = '  Dossiers Parents  '
    TabOrder = 3
    object ExcParents: TRadioButton
      Left = 20
      Top = 25
      Width = 98
      Height = 21
      Caption = 'Exclude filter'
      TabOrder = 0
    end
    object IncParents: TRadioButton
      Left = 20
      Top = 49
      Width = 98
      Height = 21
      Caption = 'Include Filter'
      TabOrder = 1
    end
    object EditParents: TEdit
      Left = 26
      Top = 79
      Width = 80
      Height = 24
      TabOrder = 2
      Text = '1'
    end
  end
  object Button1: TButton
    Left = 152
    Top = 336
    Width = 145
    Height = 25
    Caption = 'OK'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 336
    Width = 137
    Height = 25
    Caption = 'Cancel'
    TabOrder = 5
    OnClick = Button2Click
  end
  object GroupBox5: TGroupBox
    Left = 5
    Top = 246
    Width = 140
    Height = 83
    Caption = ' Html Parse '
    TabOrder = 6
    object ExcParse: TRadioButton
      Left = 20
      Top = 25
      Width = 98
      Height = 21
      Caption = 'Exclude filter'
      TabOrder = 0
    end
    object IncParse: TRadioButton
      Left = 20
      Top = 49
      Width = 98
      Height = 21
      Caption = 'Include Filter'
      TabOrder = 1
    end
  end
end
