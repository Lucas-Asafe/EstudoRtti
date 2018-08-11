inherited frmCadastroCliente: TfrmCadastroCliente
  ActiveControl = Edit1
  Caption = 'Cadastro de Clientes'
  ClientWidth = 776
  OnCreate = FormCreate
  ExplicitWidth = 792
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 8
    Top = 260
    Width = 24
    Height = 13
    Caption = 'Sexo'
  end
  object Label2: TLabel [1]
    Left = 138
    Top = 260
    Width = 55
    Height = 13
    Caption = 'Nascimento'
  end
  object Label3: TLabel [2]
    Left = 241
    Top = 260
    Width = 44
    Height = 13
    Caption = 'Cadastro'
  end
  object Label4: TLabel [3]
    Left = 360
    Top = 260
    Width = 35
    Height = 13
    Caption = 'Cr'#233'dito'
  end
  object Label5: TLabel [4]
    Left = 8
    Top = 212
    Width = 45
    Height = 13
    Caption = 'Endere'#231'o'
  end
  object Label6: TLabel [5]
    Left = 8
    Top = 165
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object Label7: TLabel [6]
    Left = 87
    Top = 165
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object Label8: TLabel [7]
    Left = 323
    Top = 165
    Width = 54
    Height = 13
    Caption = 'Documento'
  end
  object Label9: TLabel [8]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 770
    Height = 19
    Align = alTop
    Caption = 'Busca: Tabela Clientes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 158
  end
  object lbl1: TLabel [9]
    Left = 444
    Top = 165
    Width = 42
    Height = 13
    Caption = 'Telefone'
  end
  inherited btnCancelar: TButton
    Top = 330
    TabOrder = 8
    ExplicitTop = 330
  end
  inherited btnNovo: TButton
    Top = 330
    TabOrder = 9
    ExplicitTop = 330
  end
  inherited Panel1: TPanel
    Top = 408
    Width = 776
    Height = 72
    TabOrder = 10
    ExplicitTop = 408
    ExplicitHeight = 72
    inherited ListBox1: TListBox
      Width = 758
      Height = 54
      ExplicitHeight = 54
    end
  end
  inherited btnSalvar: TButton
    Top = 330
    TabOrder = 11
    ExplicitTop = 330
  end
  inherited btnExcluir: TButton
    Top = 330
    TabOrder = 12
    ExplicitTop = 330
  end
  inherited btnEditar: TButton
    Top = 330
    TabOrder = 13
    ExplicitTop = 330
  end
  inherited StringGrid: TStringGrid
    Top = 58
    Width = 770
    Height = 101
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goTabs, goRowSelect, goThumbTracking, goFixedColClick, goFixedRowClick, goFixedHotTrack]
    TabOrder = 14
    OnSelectCell = StringGridSelectCell
    ExplicitTop = 58
    ExplicitHeight = 101
    RowHeights = (
      24
      25)
  end
  object edCodigo: TEdit
    Left = 8
    Top = 184
    Width = 73
    Height = 21
    NumbersOnly = True
    TabOrder = 0
  end
  object edNome: TEdit
    Left = 87
    Top = 184
    Width = 230
    Height = 21
    TabOrder = 1
  end
  object edDocumento: TEdit
    Left = 323
    Top = 184
    Width = 115
    Height = 21
    TabOrder = 2
  end
  object edEndereco: TEdit
    Left = 8
    Top = 231
    Width = 430
    Height = 21
    TabOrder = 3
  end
  object edCredito: TEdit
    Left = 360
    Top = 279
    Width = 78
    Height = 21
    NumbersOnly = True
    TabOrder = 4
  end
  object cbSexo: TComboBox
    Left = 8
    Top = 279
    Width = 124
    Height = 21
    TabOrder = 5
    Items.Strings = (
      'Masculino'
      'Feminino')
  end
  object dtDataNascimento: TJvDateTimePicker
    Left = 138
    Top = 280
    Width = 97
    Height = 21
    Date = 0.800771655092830700
    Time = 0.800771655092830700
    DoubleBuffered = False
    ParentDoubleBuffered = False
    TabOrder = 6
    DropDownDate = 42599.000000000000000000
    NullText = '00/00/0000'
  end
  object dtDataCadastro: TJvDateTimePicker
    Left = 241
    Top = 280
    Width = 113
    Height = 21
    Date = 0.800771655092830700
    Time = 0.800771655092830700
    TabOrder = 7
    DropDownDate = 42565.000000000000000000
    NullText = '00/00/0000'
  end
  object Edit1: TEdit
    AlignWithMargins = True
    Left = 3
    Top = 28
    Width = 770
    Height = 24
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 15
    OnKeyUp = Edit1KeyUp
    ExplicitWidth = 440
  end
  object Button1: TButton
    Left = 8
    Top = 361
    Width = 169
    Height = 25
    Caption = 'Gerar Relat'#243'rio'
    TabOrder = 16
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 183
    Top = 361
    Width = 167
    Height = 25
    Caption = '>> Exportar <<'
    TabOrder = 17
    OnClick = Button2Click
  end
  object grdTelefones: TStringGrid
    AlignWithMargins = True
    Left = 444
    Top = 231
    Width = 324
    Height = 184
    Color = clWhite
    ColCount = 2
    DrawingStyle = gdsGradient
    RowCount = 2
    GradientEndColor = clSilver
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goTabs, goRowSelect, goThumbTracking, goFixedColClick, goFixedRowClick, goFixedHotTrack]
    TabOrder = 18
    ColWidths = (
      64
      242)
    RowHeights = (
      24
      25)
  end
  object edtTelefone: TEdit
    Left = 444
    Top = 184
    Width = 261
    Height = 21
    TabOrder = 19
  end
  object btn1: TButton
    Left = 711
    Top = 182
    Width = 57
    Height = 25
    Caption = ':: Add ::'
    TabOrder = 20
    OnClick = btn1Click
  end
end
