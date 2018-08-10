object FormBase: TFormBase
  Left = 387
  Top = 118
  Align = alCustom
  Caption = 'FormBase'
  ClientHeight = 480
  ClientWidth = 446
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnCancelar: TButton
    Left = 358
    Top = 299
    Width = 80
    Height = 25
    Caption = ':: Cancelar ::'
    TabOrder = 0
    OnClick = btnCancelarClick
  end
  object btnNovo: TButton
    Left = 8
    Top = 299
    Width = 80
    Height = 25
    Caption = ':: Novo ::'
    TabOrder = 1
    OnClick = btnNovoClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 330
    Width = 446
    Height = 150
    Align = alBottom
    TabOrder = 2
    object ListBox1: TListBox
      AlignWithMargins = True
      Left = 9
      Top = 9
      Width = 428
      Height = 132
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 221
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ItemHeight = 13
      ParentFont = False
      TabOrder = 0
    end
  end
  object btnSalvar: TButton
    Left = 270
    Top = 299
    Width = 80
    Height = 25
    Caption = ':: Salvar ::'
    TabOrder = 3
    OnClick = btnSalvarClick
  end
  object btnExcluir: TButton
    Left = 183
    Top = 299
    Width = 80
    Height = 25
    Caption = ':: Excluir ::'
    TabOrder = 4
    OnClick = btnExcluirClick
  end
  object btnEditar: TButton
    Left = 95
    Top = 299
    Width = 80
    Height = 25
    Caption = ':: Editar ::'
    TabOrder = 5
    OnClick = btnEditarClick
  end
  object StringGrid: TStringGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 440
    Height = 120
    Align = alTop
    Color = clWhite
    ColCount = 3
    DrawingStyle = gdsGradient
    RowCount = 2
    GradientEndColor = clSilver
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goTabs, goRowSelect, goThumbTracking, goFixedColClick, goFixedRowClick, goFixedHotTrack]
    TabOrder = 6
    ColWidths = (
      64
      92
      215)
    RowHeights = (
      24
      24)
  end
end
