object DM: TDM
  OldCreateOrder = False
  Height = 263
  Width = 481
  object frxReport1: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42622.633289976900000000
    ReportOptions.LastChange = 42625.478924895800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 360
    Top = 24
    Datasets = <
      item
        DataSet = frxUserDataSet1
        DataSetName = 'frxUserDataSet1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 170.078850000000000000
        Width = 740.409927000000000000
        DataSet = frxUserDataSet1
        DataSetName = 'frxUserDataSet1'
        RowCount = 0
        object frxUserDataSet1Credito: TfrxMemoView
          Left = 679.937447000000000000
          Top = 3.779529999999990000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DataSet = frxUserDataSet1
          DataSetName = 'frxUserDataSet1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserDataSet1."Credito"]')
          ParentFont = False
        end
        object frxUserDataSet1Codigo: TfrxMemoView
          Top = 3.779529999999990000
          Width = 30.236240000000000000
          Height = 18.897650000000000000
          DataSet = frxUserDataSet1
          DataSetName = 'frxUserDataSet1'
          DisplayFormat.FormatStr = '000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUserDataSet1."Codigo"]')
          ParentFont = False
        end
        object frxUserDataSet1Nome: TfrxMemoView
          Align = baLeft
          Left = 30.236240000000000000
          Top = 3.779529999999990000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          DataField = 'Nome'
          DataSet = frxUserDataSet1
          DataSetName = 'frxUserDataSet1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUserDataSet1."Nome"]')
          ParentFont = False
        end
        object frxUserDataSet1Documento: TfrxMemoView
          Align = baLeft
          Left = 173.858380000000000000
          Top = 3.779529999999990000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          DataField = 'Documento'
          DataSet = frxUserDataSet1
          DataSetName = 'frxUserDataSet1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUserDataSet1."Documento"]')
          ParentFont = False
        end
        object frxUserDataSet1Endereco: TfrxMemoView
          Left = 257.008040000000000000
          Top = 3.779529999999990000
          Width = 219.212740000000000000
          Height = 18.897650000000000000
          DataField = 'Endereco'
          DataSet = frxUserDataSet1
          DataSetName = 'frxUserDataSet1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUserDataSet1."Endereco"]')
          ParentFont = False
        end
        object frxUserDataSet1Sexo: TfrxMemoView
          Align = baRight
          Left = 475.087028890000000000
          Top = 3.779529999999990000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          DataSet = frxUserDataSet1
          DataSetName = 'frxUserDataSet1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          Fill.BackColor = clWhite
          HAlign = haCenter
          Memo.UTF8W = (
            '[Copy(<frxUserDataSet1."Sexo">,1,1)]')
          ParentFont = False
        end
        object frxUserDataSet1DataNascimento: TfrxMemoView
          Align = baRight
          Left = 512.882328890000000000
          Top = 3.779529999999990000
          Width = 83.149606300000000000
          Height = 18.897650000000000000
          DataField = 'DataNascimento'
          DataSet = frxUserDataSet1
          DataSetName = 'frxUserDataSet1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUserDataSet1."DataNascimento"]')
          ParentFont = False
        end
        object frxUserDataSet1DataCadastro: TfrxMemoView
          Align = baRight
          Left = 596.031935190000000000
          Top = 3.779529999999990000
          Width = 83.905511810000000000
          Height = 18.897650000000000000
          DataField = 'DataCadastro'
          DataSet = frxUserDataSet1
          DataSetName = 'frxUserDataSet1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUserDataSet1."DataCadastro"]')
          ParentFont = False
        end
      end
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 18.897650000000000000
        Width = 740.409927000000000000
        object Memo1: TfrxMemoView
          Align = baClient
          Width = 740.409927000000000000
          Height = 41.574830000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -27
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CADASTRO')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 120.944960000000000000
        Width = 740.409927000000000000
        object Memo2: TfrxMemoView
          Align = baLeft
          Top = 3.779529999999990000
          Width = 30.236240000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'd')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baLeft
          Left = 30.236240000000000000
          Top = 3.779529999999990000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Nome')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Align = baLeft
          Left = 173.858380000000000000
          Top = 3.779529999999990000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Documento')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Align = baRight
          Left = 475.087028890000000000
          Top = 3.779529999999990000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Sexo')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Align = baRight
          Left = 512.882328890000000000
          Top = 3.779529999999990000
          Width = 83.149606300000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Nascimento')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Align = baRight
          Left = 596.031935190000000000
          Top = 3.779529999999990000
          Width = 83.905511810000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cadastro')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Align = baRight
          Left = 679.937447000000000000
          Top = 3.779529999999990000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cr'#233'dito')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 257.008040000000000000
          Top = 3.779529999999990000
          Width = 219.212617950000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'o')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Top = 22.677180000000000000
          Width = 740.787880000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
      end
    end
  end
  object frxUserDataSet1: TfrxUserDataSet
    UserName = 'frxUserDataSet1'
    Fields.Strings = (
      'Codigo'
      'Nome'
      'Documento'
      'Endereco'
      'Sexo'
      'DataNascimento'
      'DataCadastro'
      'Credito')
    OnGetValue = frxUserDataSet1GetValue
    Left = 216
    Top = 24
  end
end
