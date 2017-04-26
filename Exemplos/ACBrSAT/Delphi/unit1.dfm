object Form1: TForm1
  Left = 327
  Top = 132
  Width = 836
  Height = 581
  Caption = 'SAT Teste - Projeto ACBr'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 202
    Width = 820
    Height = 6
    Cursor = crVSplit
    Align = alTop
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 208
    Width = 820
    Height = 291
    ActivePage = tsRecebido
    Align = alClient
    TabOrder = 0
    object tsLog: TTabSheet
      Caption = 'Log de Comandos'
      object mLog: TMemo
        Left = 0
        Top = 0
        Width = 795
        Height = 263
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Lucida Console'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object tsGerado: TTabSheet
      Caption = 'XML Gerado'
      inline mVendaEnviar: TMemo
        Left = 0
        Top = 0
        Width = 795
        Height = 263
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object tsRecebido: TTabSheet
      Caption = 'XML Recebido'
      inline mRecebido: TWebBrowser
        Left = 0
        Top = 0
        Width = 812
        Height = 263
        Align = alClient
        TabOrder = 0
        ControlData = {
          4C000000EC5300002F1B00000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
    object tsCancelamento: TTabSheet
      Caption = 'XML Cancelamento'
      inline mCancelamentoEnviar: TMemo
        Left = 0
        Top = 0
        Width = 795
        Height = 238
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object Panel2: TPanel
        Left = 0
        Top = 238
        Width = 795
        Height = 25
        Align = alBottom
        TabOrder = 1
        object Label18: TLabel
          Left = 1
          Top = 1
          Width = 105
          Height = 13
          Align = alLeft
          Caption = 'Chave Cancelamento:'
          Color = clBtnFace
          ParentColor = False
          Layout = tlCenter
        end
        object edChaveCancelamento: TEdit
          Left = 127
          Top = 1
          Width = 581
          Height = 21
          TabOrder = 0
        end
      end
    end
    object tsRedeXML: TTabSheet
      Caption = 'XML Rede'
      ImageIndex = 4
      inline mRede: TWebBrowser
        Left = 0
        Top = 0
        Width = 795
        Height = 263
        Align = alClient
        TabOrder = 0
        ControlData = {
          4C0000002A5200002F1B00000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 820
    Height = 202
    Align = alTop
    TabOrder = 2
    object gpOperacao: TGroupBox
      Left = 1
      Top = 1
      Width = 169
      Height = 200
      Align = alLeft
      Caption = 'Inicializa'#231#227'o'
      TabOrder = 0
      object bInicializar: TButton
        Left = 30
        Top = 55
        Width = 105
        Height = 33
        Caption = 'Inicializar'
        TabOrder = 0
        OnClick = bInicializarClick
      end
      object cbxModelo: TComboBox
        Left = 16
        Top = 24
        Width = 133
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = cbxModeloChange
        Items.Strings = (
          'Procurar'
          'ecfNaoFiscal'
          'ecfBematech'
          'ecfSweda'
          'ecfDaruma'
          'ecfSchalter'
          'ecfMecaf'
          'ecfYanco'
          'ecfDataRegis'
          'ecfUrano'
          'ecfICash'
          'ecfQuattro')
      end
      object GroupBox2: TGroupBox
        Left = 2
        Top = 109
        Width = 165
        Height = 89
        Align = alBottom
        Caption = 'Par'#226'metros'
        TabOrder = 2
        object btLerParams: TButton
          Left = 31
          Top = 20
          Width = 105
          Height = 25
          Caption = 'Ler'
          TabOrder = 0
          OnClick = btLerParamsClick
        end
        object btSalvarParams: TButton
          Left = 31
          Top = 52
          Width = 105
          Height = 25
          Caption = 'Salvar'
          TabOrder = 1
          OnClick = btSalvarParamsClick
        end
      end
    end
    object GroupBox1: TGroupBox
      Left = 170
      Top = 1
      Width = 649
      Height = 200
      Align = alClient
      Caption = 'Configura'#231#227'o'
      TabOrder = 1
      object PageControl2: TPageControl
        Left = 2
        Top = 15
        Width = 645
        Height = 183
        ActivePage = tsMFE
        Align = alClient
        TabOrder = 0
        object tsDadosSAT: TTabSheet
          Caption = 'Dados do SAT CFe'
          object Label9: TLabel
            Left = 21
            Top = 7
            Width = 40
            Height = 13
            Alignment = taRightJustify
            Caption = 'Arq.Log:'
            Color = clBtnFace
            ParentColor = False
          end
          object SbArqLog: TSpeedButton
            Left = 185
            Top = 24
            Width = 24
            Height = 22
            Caption = '...'
            OnClick = SbArqLogClick
          end
          object Label10: TLabel
            Left = 222
            Top = 7
            Width = 54
            Height = 13
            Alignment = taRightJustify
            Caption = 'Nome DLL:'
            Color = clBtnFace
            ParentColor = False
          end
          object Label1: TLabel
            Left = 16
            Top = 56
            Width = 93
            Height = 13
            Caption = 'C'#243'digo de Ativa'#231#227'o'
            Color = clBtnFace
            ParentColor = False
          end
          object Label4: TLabel
            Left = 217
            Top = 56
            Width = 36
            Height = 13
            Caption = 'C'#243'd.UF'
            Color = clBtnFace
            ParentColor = False
          end
          object Label3: TLabel
            Left = 312
            Top = 57
            Width = 51
            Height = 13
            Caption = 'Num.Caixa'
            Color = clBtnFace
            ParentColor = False
          end
          object Label8: TLabel
            Left = 152
            Top = 106
            Width = 58
            Height = 13
            Caption = 'P'#225'g.C'#243'digo:'
            Color = clBtnFace
            ParentColor = False
          end
          object Label13: TLabel
            Left = 257
            Top = 106
            Width = 33
            Height = 13
            Caption = 'Vers'#227'o'
            Color = clBtnFace
            ParentColor = False
          end
          object Label6: TLabel
            Left = 377
            Top = 55
            Width = 44
            Height = 13
            Caption = 'Ambiente'
            Color = clBtnFace
            ParentColor = False
          end
          object edLog: TEdit
            Left = 17
            Top = 24
            Width = 163
            Height = 21
            Cursor = crIBeam
            TabOrder = 0
          end
          object edNomeDLL: TEdit
            Left = 217
            Top = 24
            Width = 388
            Height = 21
            Cursor = crIBeam
            TabOrder = 1
          end
          object edtCodigoAtivacao: TEdit
            Left = 16
            Top = 72
            Width = 164
            Height = 21
            TabOrder = 2
          end
          object edtCodUF: TEdit
            Left = 218
            Top = 72
            Width = 61
            Height = 21
            TabOrder = 3
          end
          object seNumeroCaixa: TSpinEdit
            Left = 312
            Top = 73
            Width = 58
            Height = 22
            MaxValue = 999
            MinValue = 1
            TabOrder = 4
            Value = 1
          end
          object cbxUTF8: TCheckBox
            Left = 16
            Top = 103
            Width = 47
            Height = 19
            Caption = 'UTF8'
            TabOrder = 5
            OnClick = cbxUTF8Change
          end
          object sePagCod: TSpinEdit
            Left = 152
            Top = 123
            Width = 83
            Height = 22
            MaxValue = 65001
            MinValue = 0
            TabOrder = 6
            Value = 0
            OnChange = sePagCodChange
          end
          object sfeVersaoEnt: TEdit
            Left = 256
            Top = 123
            Width = 114
            Height = 21
            TabOrder = 7
            OnChange = sfeVersaoEntChange
          end
          object cbxFormatXML: TCheckBox
            Left = 17
            Top = 127
            Width = 95
            Height = 19
            Caption = 'Formatar XML'
            Checked = True
            State = cbChecked
            TabOrder = 8
            OnClick = cbxUTF8Change
          end
          object cbxAmbiente: TComboBox
            Left = 377
            Top = 72
            Width = 120
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 9
          end
          object cbxSalvarCFe: TCheckBox
            Left = 504
            Top = 72
            Width = 79
            Height = 19
            Caption = 'Salvar CFes'
            Checked = True
            State = cbChecked
            TabOrder = 10
            OnClick = cbxSalvarCFeChange
          end
          object cbxSalvarCFeCanc: TCheckBox
            Left = 504
            Top = 99
            Width = 100
            Height = 19
            Caption = 'Salvar CFeCanc'
            Checked = True
            State = cbChecked
            TabOrder = 11
            OnClick = cbxSalvarCFeCancChange
          end
          object cbxSalvarEnvio: TCheckBox
            Left = 504
            Top = 126
            Width = 82
            Height = 19
            Caption = 'Salvar Envio'
            Checked = True
            State = cbChecked
            TabOrder = 12
            OnClick = cbxSalvarEnvioChange
          end
          object cbxSepararPorCNPJ: TCheckBox
            Left = 377
            Top = 99
            Width = 112
            Height = 19
            Caption = 'Separar por CNPJ'
            Checked = True
            State = cbChecked
            TabOrder = 13
            OnClick = cbxSepararPorCNPJChange
          end
          object cbxSepararPorMES: TCheckBox
            Left = 377
            Top = 126
            Width = 112
            Height = 19
            Caption = 'Separar por MES'
            Checked = True
            State = cbChecked
            TabOrder = 14
            OnClick = cbxSepararPorMESChange
          end
        end
        object tsDadosEmit: TTabSheet
          Caption = 'Dados Emitente'
          object Label11: TLabel
            Left = 12
            Top = 23
            Width = 27
            Height = 13
            Caption = 'CNPJ'
            Color = clBtnFace
            ParentColor = False
          end
          object Label12: TLabel
            Left = 192
            Top = 23
            Width = 64
            Height = 13
            Caption = 'Insc.Estadual'
            Color = clBtnFace
            ParentColor = False
          end
          object Label14: TLabel
            Left = 336
            Top = 23
            Width = 68
            Height = 13
            Caption = 'Insc.Municipal'
            Color = clBtnFace
            ParentColor = False
          end
          object Label15: TLabel
            Left = 192
            Top = 71
            Width = 96
            Height = 13
            Caption = 'Regime Trib. ISSQN'
            Color = clBtnFace
            ParentColor = False
          end
          object Label16: TLabel
            Left = 336
            Top = 71
            Width = 71
            Height = 13
            Caption = 'Ind.Rat.ISSQN'
            Color = clBtnFace
            ParentColor = False
          end
          object Label17: TLabel
            Left = 12
            Top = 73
            Width = 83
            Height = 13
            Caption = 'Regime Tributario'
            Color = clBtnFace
            ParentColor = False
          end
          object edtEmitCNPJ: TEdit
            Left = 12
            Top = 38
            Width = 166
            Height = 21
            Cursor = crIBeam
            TabOrder = 0
          end
          object edtEmitIE: TEdit
            Left = 192
            Top = 38
            Width = 134
            Height = 21
            Cursor = crIBeam
            TabOrder = 1
          end
          object edtEmitIM: TEdit
            Left = 336
            Top = 38
            Width = 134
            Height = 21
            Cursor = crIBeam
            TabOrder = 2
          end
          object cbxRegTribISSQN: TComboBox
            Left = 192
            Top = 87
            Width = 130
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 4
          end
          object cbxIndRatISSQN: TComboBox
            Left = 336
            Top = 87
            Width = 134
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 5
          end
          object cbxRegTributario: TComboBox
            Left = 12
            Top = 87
            Width = 166
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 3
          end
        end
        object tsDadosSwHouse: TTabSheet
          Caption = 'Dados Sw.House'
          DesignSize = (
            637
            155)
          object Label2: TLabel
            Left = 10
            Top = 15
            Width = 27
            Height = 13
            Caption = 'CNPJ'
            Color = clBtnFace
            ParentColor = False
          end
          object Label5: TLabel
            Left = 10
            Top = 71
            Width = 181
            Height = 13
            Caption = 'Assinatura Sw.House (344 caracteres)'
            Color = clBtnFace
            ParentColor = False
          end
          object edtSwHCNPJ: TEdit
            Left = 10
            Top = 31
            Width = 329
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
          end
          object edtSwHAssinatura: TEdit
            Left = 10
            Top = 89
            Width = 594
            Height = 21
            TabOrder = 1
          end
        end
        object tsRede: TTabSheet
          Caption = 'Rede'
          ImageIndex = 4
          object gbIPFix: TGroupBox
            Left = 160
            Top = 48
            Width = 289
            Height = 105
            Caption = 'IPFIX'
            TabOrder = 1
            Visible = False
            object lSSID2: TLabel
              Left = 36
              Top = 21
              Width = 10
              Height = 13
              Caption = 'IP'
              Color = clBtnFace
              ParentColor = False
            end
            object lSSID3: TLabel
              Left = 21
              Top = 51
              Width = 26
              Height = 13
              Caption = 'Mask'
              Color = clBtnFace
              ParentColor = False
            end
            object lSSID4: TLabel
              Left = 4
              Top = 81
              Width = 42
              Height = 13
              Caption = 'Gateway'
              Color = clBtnFace
              ParentColor = False
            end
            object lSSID5: TLabel
              Left = 160
              Top = 21
              Width = 29
              Height = 13
              Caption = 'DNS1'
              Color = clBtnFace
              ParentColor = False
            end
            object lSSID6: TLabel
              Left = 159
              Top = 49
              Width = 29
              Height = 13
              Caption = 'DNS2'
              Color = clBtnFace
              ParentColor = False
            end
            object edRedeIP: TEdit
              Left = 60
              Top = 13
              Width = 88
              Height = 21
              TabOrder = 0
            end
            object edRedeMask: TEdit
              Left = 60
              Top = 43
              Width = 88
              Height = 21
              TabOrder = 1
            end
            object edRedeGW: TEdit
              Left = 60
              Top = 73
              Width = 88
              Height = 21
              TabOrder = 2
            end
            object edRedeDNS1: TEdit
              Left = 196
              Top = 13
              Width = 87
              Height = 21
              TabOrder = 3
            end
            object edRedeDNS2: TEdit
              Left = 196
              Top = 43
              Width = 87
              Height = 21
              TabOrder = 4
            end
          end
          object gbPPPoE: TGroupBox
            Left = 160
            Top = 48
            Width = 289
            Height = 105
            Caption = 'PPPoE'
            TabOrder = 0
            Visible = False
            object lSSID7: TLabel
              Left = 17
              Top = 24
              Width = 36
              Height = 13
              Caption = 'Usuario'
              Color = clBtnFace
              ParentColor = False
            end
            object lSSID8: TLabel
              Left = 17
              Top = 54
              Width = 31
              Height = 13
              Caption = 'Senha'
              Color = clBtnFace
              ParentColor = False
            end
            object edRedeUsuario: TEdit
              Left = 64
              Top = 16
              Width = 88
              Height = 21
              TabOrder = 0
            end
            object edRedeSenha: TEdit
              Left = 64
              Top = 46
              Width = 88
              Height = 21
              TabOrder = 1
            end
          end
          object rgRedeTipoInter: TRadioGroup
            Left = 4
            Top = 0
            Width = 144
            Height = 41
            Caption = 'Tipo Rede'
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              'ETHE'
              'WIFI')
            TabOrder = 2
            OnClick = rgRedeTipoInterClick
          end
          object gbWiFi: TGroupBox
            Left = 4
            Top = 48
            Width = 144
            Height = 105
            Caption = 'WiFi'
            TabOrder = 3
            Visible = False
            object lSSID: TLabel
              Left = 8
              Top = 22
              Width = 28
              Height = 13
              Caption = 'SSID:'
              Color = clBtnFace
              ParentColor = False
            end
            object Label24: TLabel
              Left = 8
              Top = 52
              Width = 22
              Height = 13
              Caption = 'Seg:'
              Color = clBtnFace
              ParentColor = False
            end
            object lSSID1: TLabel
              Left = 8
              Top = 82
              Width = 31
              Height = 13
              Caption = 'Senha'
              Color = clBtnFace
              ParentColor = False
            end
            object edRedeSSID: TEdit
              Left = 47
              Top = 14
              Width = 82
              Height = 21
              TabOrder = 0
            end
            object cbxRedeSeg: TComboBox
              Left = 47
              Top = 44
              Width = 82
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              ItemIndex = 1
              TabOrder = 1
              Text = 'WEP'
              Items.Strings = (
                'NONE'
                'WEP'
                'WPA-PERSONAL'
                'WPA-ENTERPRISE')
            end
            object edRedeCodigo: TEdit
              Left = 47
              Top = 74
              Width = 82
              Height = 21
              TabOrder = 2
            end
          end
          object rgRedeTipoLan: TRadioGroup
            Left = 160
            Top = 0
            Width = 288
            Height = 41
            Caption = 'Tipo Rede'
            Columns = 3
            ItemIndex = 0
            Items.Strings = (
              'DHCP'
              'PPPoE'
              'IPFIX')
            TabOrder = 4
            OnClick = rgRedeTipoLanClick
          end
          object gbProxy: TGroupBox
            Left = 458
            Top = 0
            Width = 150
            Height = 153
            Caption = 'Proxy'
            TabOrder = 5
            object lSSID9: TLabel
              Left = 24
              Top = 48
              Width = 10
              Height = 13
              Caption = 'IP'
              Color = clBtnFace
              ParentColor = False
            end
            object lSSID10: TLabel
              Left = 11
              Top = 78
              Width = 25
              Height = 13
              Caption = 'Porta'
              Color = clBtnFace
              ParentColor = False
            end
            object lSSID11: TLabel
              Left = 3
              Top = 104
              Width = 36
              Height = 13
              Caption = 'Usuario'
              Color = clBtnFace
              ParentColor = False
            end
            object lSSID12: TLabel
              Left = 8
              Top = 130
              Width = 31
              Height = 13
              Caption = 'Senha'
              Color = clBtnFace
              ParentColor = False
            end
            object cbxRedeProxy: TComboBox
              Left = 8
              Top = 16
              Width = 129
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              ItemIndex = 0
              TabOrder = 0
              Text = '0= N'#227'o usa proxy'
              OnChange = cbxRedeProxyChange
              Items.Strings = (
                '0= N'#227'o usa proxy'
                '1= Proxy com configura'#231#227'o'
                '2= Proxy transparente')
            end
            object edRedeProxyIP: TEdit
              Left = 49
              Top = 44
              Width = 88
              Height = 21
              Enabled = False
              TabOrder = 1
            end
            object edRedeProxyUser: TEdit
              Left = 49
              Top = 96
              Width = 88
              Height = 21
              Enabled = False
              TabOrder = 2
            end
            object edRedeProxySenha: TEdit
              Left = 49
              Top = 122
              Width = 88
              Height = 21
              Enabled = False
              TabOrder = 3
            end
            object edRedeProxyPorta: TSpinEdit
              Left = 49
              Top = 70
              Width = 88
              Height = 22
              Enabled = False
              MaxValue = 999999
              MinValue = 0
              TabOrder = 4
              Value = 0
            end
          end
        end
        object Impressao: TTabSheet
          Caption = 'Impressao'
          object GroupBox3: TGroupBox
            Left = 0
            Top = 0
            Width = 310
            Height = 155
            Align = alClient
            Caption = 'Fortes'
            TabOrder = 0
            object Label19: TLabel
              Left = 8
              Top = 16
              Width = 36
              Height = 13
              Caption = 'Largura'
              Color = clBtnFace
              ParentColor = False
            end
            object Label20: TLabel
              Left = 96
              Top = 16
              Width = 25
              Height = 13
              Caption = 'Topo'
              Color = clBtnFace
              ParentColor = False
            end
            object Label21: TLabel
              Left = 8
              Top = 64
              Width = 30
              Height = 13
              Caption = 'Fundo'
              Color = clBtnFace
              ParentColor = False
            end
            object Label22: TLabel
              Left = 96
              Top = 64
              Width = 45
              Height = 13
              Caption = 'Esquerda'
              Color = clBtnFace
              ParentColor = False
            end
            object Label23: TLabel
              Left = 184
              Top = 64
              Width = 30
              Height = 13
              Caption = 'Direita'
              Color = clBtnFace
              ParentColor = False
            end
            object lImpressora: TLabel
              Left = 136
              Top = 120
              Width = 93
              Height = 13
              Caption = 'Impresssora Default'
              Color = clBtnFace
              ParentColor = False
            end
            object seLargura: TSpinEdit
              Left = 8
              Top = 30
              Width = 64
              Height = 22
              MaxValue = 9999
              MinValue = 0
              TabOrder = 0
              Value = 0
            end
            object seMargemTopo: TSpinEdit
              Left = 96
              Top = 30
              Width = 64
              Height = 22
              MaxValue = 9999
              MinValue = 0
              TabOrder = 1
              Value = 0
            end
            object seMargemFundo: TSpinEdit
              Left = 8
              Top = 78
              Width = 64
              Height = 22
              MaxValue = 9999
              MinValue = 0
              TabOrder = 2
              Value = 0
            end
            object seMargemEsquerda: TSpinEdit
              Left = 96
              Top = 78
              Width = 64
              Height = 22
              MaxValue = 9999
              MinValue = 0
              TabOrder = 3
              Value = 0
            end
            object seMargemDireita: TSpinEdit
              Left = 184
              Top = 78
              Width = 64
              Height = 22
              MaxValue = 9999
              MinValue = 0
              TabOrder = 4
              Value = 0
            end
            object bImpressora: TButton
              Left = 8
              Top = 112
              Width = 122
              Height = 25
              Caption = 'Definir Impressora'
              TabOrder = 5
              OnClick = bImpressoraClick
            end
            object cbUsarFortes: TRadioButton
              Left = 184
              Top = 16
              Width = 78
              Height = 19
              Caption = 'Usar Fortes'
              TabOrder = 6
              OnClick = cbUsarFortesClick
            end
            object cbPreview: TCheckBox
              Left = 192
              Top = 40
              Width = 61
              Height = 19
              Caption = 'Preview'
              TabOrder = 7
            end
          end
          object GroupBox4: TGroupBox
            Left = 310
            Top = 0
            Width = 327
            Height = 155
            Align = alRight
            Caption = 'EscPOS'
            TabOrder = 1
            DesignSize = (
              327
              155)
            object Label25: TLabel
              Left = 8
              Top = 39
              Width = 35
              Height = 13
              Caption = 'Modelo'
              Color = clBtnFace
              ParentColor = False
            end
            object Label26: TLabel
              Left = 160
              Top = 39
              Width = 25
              Height = 13
              Caption = 'Porta'
              Color = clBtnFace
              ParentColor = False
            end
            object Label7: TLabel
              Left = 221
              Top = 108
              Width = 55
              Height = 13
              Caption = 'Pag.Codigo'
              Color = clBtnFace
              ParentColor = False
            end
            object Label27: TLabel
              Left = 8
              Top = 108
              Width = 38
              Height = 13
              Caption = 'Colunas'
              Color = clBtnFace
              ParentColor = False
            end
            object Label28: TLabel
              Left = 80
              Top = 95
              Width = 41
              Height = 26
              Caption = 'Espa'#231'os'#13#10'Linhas'
              Color = clBtnFace
              ParentColor = False
            end
            object Label29: TLabel
              Left = 144
              Top = 95
              Width = 31
              Height = 26
              Caption = 'Linhas'#13#10'Pular'
              Color = clBtnFace
              ParentColor = False
            end
            object btSerial: TBitBtn
              Left = 297
              Top = 53
              Width = 22
              Height = 22
              Anchors = [akTop, akRight]
              ModalResult = 1
              TabOrder = 0
              OnClick = btSerialClick
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF323232
                3232323E3E3E565656FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3E3E3EFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF565656FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3E3E3EFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF503200FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                565656565656FFFFFFFFFFFF3232322626262626262626262626265032005032
                000000504873FFFFFFFFFFFFFFFFFFFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFF6E
                6E6E32323232323232323232323250320000005025AAFFFFFFFFFFFFFF565656
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5656563232323232326E6E6E5032005032
                008FFF6B8ED4FFFFFFFFFFFFFFFFFFFF3E3E3EFFFFFFFFFFFF50320050320056
                56564A4A4A5050003232325032005032008FFF6B8ED4FFFFFFFFFFFFFFFFFFFF
                FFFFFF5656563E3E3E2626265032006262625656565050003232325032005032
                008FFF6B8ED4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5050005050006E
                6E6E5656565050003250005032005032008FFF6B8ED4FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8686865656565656563250005032005032
                008FFF6B48B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3232323E
                3E3EA4A0A08686866E6E6E565656503200C0C0C02557FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF5050004A4A4A3232323232323232323232325032
                00FFFFFF6B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
              Layout = blGlyphTop
            end
            object cbUsarEscPos: TRadioButton
              Left = 8
              Top = 16
              Width = 85
              Height = 19
              Caption = 'Usar EscPOS'
              TabOrder = 1
              OnClick = cbUsarEscPosClick
            end
            object cbxModeloPosPrinter: TComboBox
              Left = 7
              Top = 55
              Width = 146
              Height = 21
              Style = csDropDownList
              Anchors = [akLeft, akTop, akRight]
              ItemHeight = 13
              TabOrder = 2
            end
            object cbxPorta: TComboBox
              Left = 159
              Top = 55
              Width = 138
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              ItemHeight = 13
              TabOrder = 3
            end
            object cbxPagCodigo: TComboBox
              Left = 220
              Top = 124
              Width = 100
              Height = 21
              Style = csDropDownList
              Anchors = [akLeft, akTop, akRight]
              ItemHeight = 13
              TabOrder = 4
            end
            object seColunas: TSpinEdit
              Left = 8
              Top = 124
              Width = 49
              Height = 22
              MaxValue = 9999
              MinValue = 0
              TabOrder = 5
              Value = 0
            end
            object seEspLinhas: TSpinEdit
              Left = 80
              Top = 124
              Width = 49
              Height = 22
              MaxValue = 9999
              MinValue = 0
              TabOrder = 6
              Value = 0
            end
            object seLinhasPular: TSpinEdit
              Left = 144
              Top = 124
              Width = 49
              Height = 22
              MaxValue = 9999
              MinValue = 0
              TabOrder = 7
              Value = 0
            end
            object cbImprimir1Linha: TCheckBox
              Left = 160
              Top = 16
              Width = 145
              Height = 19
              Caption = 'Imprimir Item em 1 Linha'
              TabOrder = 8
            end
          end
        end
        object tsMFE: TTabSheet
          Caption = 'MFE'
          ImageIndex = 5
          object Label30: TLabel
            Left = 8
            Top = 0
            Width = 82
            Height = 13
            Caption = 'Pasta de Entrada'
          end
          object Label31: TLabel
            Left = 8
            Top = 40
            Width = 74
            Height = 13
            Caption = 'Pasta de Sa'#237'da'
          end
          object Label32: TLabel
            Left = 8
            Top = 80
            Width = 38
            Height = 13
            Caption = 'Label32'
          end
          object edMFEInput: TEdit
            Left = 8
            Top = 16
            Width = 281
            Height = 21
            TabOrder = 0
            Text = 'c:\Integrador\Input\'
          end
          object edMFEOutput: TEdit
            Left = 8
            Top = 56
            Width = 281
            Height = 21
            TabOrder = 1
            Text = 'c:\Integrador\Output\'
          end
          object edMFETimeout: TEdit
            Left = 8
            Top = 96
            Width = 81
            Height = 21
            TabOrder = 2
            Text = '30'
          end
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 499
    Width = 820
    Height = 23
    Panels = <
      item
        Width = 200
      end
      item
        Width = 50
      end>
  end
  object MainMenu1: TMainMenu
    Left = 224
    Top = 224
    object MenuItem1: TMenuItem
      Caption = 'Ativa'#231#227'o'
      object mAtivarSAT: TMenuItem
        Caption = 'Ativar SAT'
        OnClick = mAtivarSATClick
      end
      object mComunicarCertificado: TMenuItem
        Caption = 'Comunicar Certificado'
        OnClick = mComunicarCertificadoClick
      end
      object mAssociarAssinatura: TMenuItem
        Caption = 'Associar Assinatura'
        OnClick = mAssociarAssinaturaClick
      end
      object MenuItem3: TMenuItem
        Caption = '-'
      end
      object mBloquearSAT: TMenuItem
        Caption = 'Bloquear SAT'
        OnClick = mBloquearSATClick
      end
      object mDesbloquearSAT: TMenuItem
        Caption = 'Desbloquear SAT'
        OnClick = mDesbloquearSATClick
      end
      object MenuItem4: TMenuItem
        Caption = '-'
      end
      object MenuItem5: TMenuItem
        Caption = 'Trocar  C'#243'digo de Ativa'#231#227'o'
        OnClick = MenuItem5Click
      end
    end
    object MenuItem2: TMenuItem
      Caption = 'Venda'
      object mGerarVenda: TMenuItem
        Caption = 'Gerar Venda'
        OnClick = mGerarVendaClick
      end
      object mEnviarVenda: TMenuItem
        Caption = 'Enviar Venda'
        OnClick = mEnviarVendaClick
      end
      object mImprimirExtratoVenda: TMenuItem
        Caption = 'Imprimir Extrato Venda'
        OnClick = mImprimirExtratoVendaClick
      end
      object mImprimirExtratoVendaResumido: TMenuItem
        Caption = 'Imprimir Extrato Venda Resumido'
        OnClick = mImprimirExtratoVendaResumidoClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object CarregarXML1: TMenuItem
        Caption = 'Carregar XML'
        OnClick = CarregarXML1Click
      end
    end
    object MenuItem12: TMenuItem
      Caption = 'Cancelamento'
      object miGerarXMLCancelamento: TMenuItem
        Caption = 'Gerar XML Cancelamento'
        OnClick = miGerarXMLCancelamentoClick
      end
      object miEnviarCancelamento: TMenuItem
        Caption = 'Enviar Cancelamento'
        OnClick = miEnviarCancelamentoClick
      end
      object miImprimirExtratoCancelamento: TMenuItem
        Caption = 'Imprimir Extrato Cancelamento'
        OnClick = miImprimirExtratoCancelamentoClick
      end
    end
    object MenuItem6: TMenuItem
      Caption = 'Consultas'
      object mConsultarStatusOperacional: TMenuItem
        Caption = 'Consultar Status Operacional'
        OnClick = mConsultarStatusOperacionalClick
      end
      object mConsultarSAT: TMenuItem
        Caption = 'Consultar SAT'
        OnClick = mConsultarSATClick
      end
      object mConsultarNumeroSessao: TMenuItem
        Caption = 'Consultar Numero Sess'#227'o'
        OnClick = mConsultarNumeroSessaoClick
      end
    end
    object MenuItem7: TMenuItem
      Caption = 'Configura'#231#227'o'
      object mAtaulizarSoftwareSAT: TMenuItem
        Caption = 'Atualizar Software SAT'
        OnClick = mAtaulizarSoftwareSATClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object LerXMLinterfaceRede1: TMenuItem
        Caption = 'Ler XML Interface Rede'
        OnClick = LerXMLinterfaceRede1Click
      end
      object GerarXMLInterfaceRede1: TMenuItem
        Caption = 'Gerar XML Interface Rede'
        OnClick = GerarXMLInterfaceRede1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object mConfigurarInterfaceRede: TMenuItem
        Caption = 'Configurar Interface Rede'
        OnClick = mConfigurarInterfaceRedeClick
      end
    end
    object MenuItem8: TMenuItem
      Caption = 'Diversos'
      object mTesteFimAFim: TMenuItem
        Caption = 'Teste Fim a Fim'
        OnClick = mTesteFimAFimClick
      end
      object mExtrairLogs: TMenuItem
        Caption = 'Extrair Logs'
        OnClick = mExtrairLogsClick
      end
    end
    object mLimpar: TMenuItem
      Caption = 'Limpar'
      OnClick = mLimparClick
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 224
    Top = 280
  end
  object ACBrSAT1: TACBrSAT
    Extrato = ACBrSATExtratoFortes1
    NomeDLL = 'c:\sat\SAT.DLL'
    OnGravarLog = ACBrSAT1GravarLog
    Config.infCFe_versaoDadosEnt = 0.050000000000000000
    Config.ide_numeroCaixa = 0
    Config.ide_tpAmb = taHomologacao
    Config.emit_cRegTrib = RTSimplesNacional
    Config.emit_cRegTribISSQN = RTISSMicroempresaMunicipal
    Config.emit_indRatISSQN = irSim
    Config.EhUTF8 = True
    Config.PaginaDeCodigo = 65001
    ConfigArquivos.PrefixoArqCFe = 'AD'
    ConfigArquivos.PrefixoArqCFeCanc = 'ADC'
    Rede.tipoInter = infETHE
    Rede.seg = segNONE
    Rede.tipoLan = lanDHCP
    Rede.proxy = 0
    Rede.proxy_porta = 0
    OnGetcodigoDeAtivacao = ACBrSAT1GetcodigoDeAtivacao
    OnGetsignAC = ACBrSAT1GetsignAC
    Left = 64
    Top = 224
  end
  object ACBrSATExtratoESCPOS1: TACBrSATExtratoESCPOS
    Mask_qCom = ',0.0000'
    Mask_vUnCom = ',0.000'
    SoftwareHouse = 'Projeto ACBr'
    Site = 'http://www.projetoacbr.com.br'
    MsgAppQRCode = 
      'Consulte o QR Code pelo aplicativo  "De olho na nota", dispon'#237've' +
      'l na AppStore (Apple) e PlayStore (Android)'
    PosPrinter = ACBrPosPrinter1
    Left = 64
    Top = 280
  end
  object ACBrSATExtratoFortes1: TACBrSATExtratoFortes
    ACBrSAT = ACBrSAT1
    Mask_qCom = ',0.000'
    Mask_vUnCom = ',0.00'
    PictureLogo.Data = {
      0A544A504547496D61676576400000FFD8FFE1001845786966000049492A0008
      0000000000000000000000FFEC00114475636B7900010004000000500000FFE1
      032B687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F003C
      3F787061636B657420626567696E3D22EFBBBF222069643D2257354D304D7043
      656869487A7265537A4E54637A6B633964223F3E203C783A786D706D65746120
      786D6C6E733A783D2261646F62653A6E733A6D6574612F2220783A786D70746B
      3D2241646F626520584D5020436F726520352E332D633031312036362E313435
      3636312C20323031322F30322F30362D31343A35363A32372020202020202020
      223E203C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777
      772E77332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E
      7323223E203C7264663A4465736372697074696F6E207264663A61626F75743D
      222220786D6C6E733A786D703D22687474703A2F2F6E732E61646F62652E636F
      6D2F7861702F312E302F2220786D6C6E733A786D704D4D3D22687474703A2F2F
      6E732E61646F62652E636F6D2F7861702F312E302F6D6D2F2220786D6C6E733A
      73745265663D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F31
      2E302F73547970652F5265736F75726365526566232220786D703A4372656174
      6F72546F6F6C3D2241646F62652050686F746F73686F7020435336202857696E
      646F7773292220786D704D4D3A496E7374616E636549443D22786D702E696964
      3A36433136313242393430393631314532383643424544313032334632333641
      422220786D704D4D3A446F63756D656E7449443D22786D702E6469643A364331
      3631324241343039363131453238364342454431303233463233364142223E20
      3C786D704D4D3A4465726976656446726F6D2073745265663A696E7374616E63
      6549443D22786D702E6969643A36433136313242373430393631314532383643
      42454431303233463233364142222073745265663A646F63756D656E7449443D
      22786D702E6469643A3643313631324238343039363131453238364342454431
      303233463233364142222F3E203C2F7264663A4465736372697074696F6E3E20
      3C2F7264663A5244463E203C2F783A786D706D6574613E203C3F787061636B65
      7420656E643D2272223F3EFFEE000E41646F62650064C000000001FFDB008400
      0202020202020202020203020202030403020203040504040404040506050505
      050505060607070807070609090A0A09090C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
      01030303050405090606090D0B090B0D0F0E0E0E0E0F0F0C0C0C0C0C0F0F0C0C
      0C0C0C0C0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
      0CFFC0001108006E016603011100021101031101FFC400D80000020105010101
      000000000000000000030408000205060701090A010002010501010000000000
      000000000001020003040506070809100001030302030403090A090A07010000
      010203040005061107213112411314085161718191A1223292D2D318B1C12393
      153555165617D142526233249425B5724373B33444264677095383A3D4E48657
      671100010302030404070C070605050100000100020311042112053141510661
      221307718191A1D13215B1C14252628292A223531417F0727344541608B2D233
      B32474E1C2839394436334642555FFDA000C03010002110311003F008935D4D7
      3B57279D10A2C837D9EDAA81214C0E629922327B6994464F3A654CA653CA8840
      A6914C12A645304A5348A6488E9E74C1294D279D44A9847314CA2653D94C1294
      C2795154D1D3CE98288C9A290ED464F2A2814C34D38E2B4420A8FA854240400A
      ADA2D5895DAE8A4A598CB3AFA01AB792E58CDA55C476EE7EC0B726B697215E9A
      45738FF34D5A9D4E31BD5C8D3A43B96511B2B90A93D5E11DF78D523AB47C5541
      A649C1622E3B4D904241518AE70FE69AAB1EA51BB7AA6FD3E46EE5A4CBC52F11
      09EF232F87A8D5DB6E58EDEAD5D6EF1B96B4F4590C921C694923D22AA8702A99
      69093576D42A0405F6522608068A21057C8D294E12AAEDA053040573A0A25554
      89D017C8FB282609555429825DCA42982595DB4853840340A2100F6D029C2595
      C8D2A21069532039DB4A76A2102814C15AAECA0545650517B51442EAA28A2367
      5D688DA81591472A754D334C9511279536E41309E74C90A653CA9825299473A2
      104CA6982529B472A6488E9A6094A653F7A8A54C23B28841349ECA6081474F6D
      154D309E74CA2C942832662D2861B2B2A3C3414AE786ED5030B8E0BB4E25B3B7
      BBE16D5E197D2A23B0D636E354647BD6420D35F26E528712F2D6121B76736103
      813D434AD4355E72B6B41F69201D1BFC9B56C167CBCE7EE52271CDA5C72C7DDF
      F564BCBD40E00573AD43BCB8DCE0D858E754D3E28F4AD96DB97DAC15710B70FC
      916D8CFB90DDB5B2DBED125A3CD2E37AF0527EFD6897FDE4EAB6D33EDDF131AF
      04907121ECAE0E6ECF01E959A6E8B016878248F70F4AB96C454704C06001D9D3
      5AADE779DACB5D98651D18D3DD572CD22DE94A2C44D896D909297ED6C2D3DBA0
      D3F86ACC77E3AC5A9EB431B87CE1E7A951DCBD6EFDE42D22E5856233D2A4BF6D
      EE0ABF8C901407DCACFE97FD4A42D786DE5B3D9D2C7078F21CA5584FC9ED70EA
      3878C2E45916C1D8AE81C55ADE6CACEBA347E2ABDE35DA396BBE1D135821B05C
      343CFC17F51DE4752BE2256B37FCA53C42A5987118A8DD97EC35E6D1DEADA8CB
      294EA78035D52DB58649BD6A93E92F66E51F2EF629D6B794DC86548E9F48ACB4
      7335E3058B7C4E66D5AE9D470355528405D04C96576D0298202BB7D940A812AA
      FBD489C25D7DB40A6096554298259C3C4FB290A64AA8D294C1055CA826080BE0
      0D2B9304BAB91A54C12EA3A694A8A0AFB7D940A2106A14CAD576522282A3A1A8
      8AF3AAA28ADA8A22B679D11B502B2283C34A754C2647114C9511279530413093
      4C129099472A6090A65078FB68840A6526982529A41E14C95309A6094A650795
      1489841E5EA34504D24FC14C1029846A4E838934522DF317C3EE3904A69B6185
      282C81A8156D3DD36218AB886DDD21C14ECDB0D81623B6C4DBAB410381D14389
      AE79CCDCEB6BA63334AFA576018B9DE01EFEC5B6E99A0BA53B14BBB2E3D6BB43
      28661454202401D640D6B886A5CF17DA9B888BECD8787AC7C27778BCAB75B7D2
      E280622A56D2DB1A8E558B86C8C9D67624F15785F44D35187788E1C8EBEF564E
      D74C1DB370D86BE454DD260ADB85B9A9CD042D5DD3AD9EA8F247CA6D7E9F58F4
      8A3ADE891EA116479CAE18B1E36B1DC7A41F8411B7B8313AA311BC715A892E75
      B91E52035318FE9503E4AC762D1E906B905EDBC91BDD0CEDCB2B768DCE1B9EDE
      2D3E659514A0734D5A7F4A1E958E7D1CEB4CD420DAAE5856124239D68B7F1E53
      5578C2B05213CEADA272BB614A1B8BCDA0B321099B18F0530F0EAE1EA57315D4
      B94FBCED6B41706C7299221F01E4B853E49F59BE234E856779A1DADE0EB368EE
      23F4C5730CC36BB1CCCD879CB63698F70E924C35E8147FC93FC6AF5DF2177B96
      1AF52307B39F7C6E3B7F50EC77BBD0B9B6BBCA12DB02E0333788F7F828339DED
      8DD31992F7547586D24E87435DC6D2FDB28DAB9EDCD93A22B8E3E8536A2958D0
      8AC80355654A24D4681452EA3A83ECA0A04AA8D294E12EB3F0D2A609651A0530
      4AB878FB694A29659A54F44151D68264070F0A529825CF234A9825D5411282B3
      CFDEA05408278504CAC275A54C824EA6822BCA8A2AA8A2237CFDEA2102B22DD5
      454C2653C851081444FDFA6094A6076510814D37CA9C2A65308E628840A6934E
      1294C20FC068A52994D304A534D8D7A47A68A45D071BC16EB9069E1585AC13FC
      506ADA6BA6C7B55C456CE7EC5D111B219191AF84778FF34D5B7B563E2AE3D9AF
      E0B61B0EC45FA44C652F44702091AEA9354A5D5980605347A5BC9D8A75EDCED6
      5AB1286C3B2A3A5C9840296C8E5EB35C33BC4EF462D209B78087DC11B37301DE
      FF0079BBF7E0B7AD1397F30CEFC1BEEAEE51C72000000D001C00F6579EDB7F71
      A84C67B8797BDDB49F7B80E80B7311B636E568A059C8E3956E1A6B060AD642B3
      4C201ADEF4F801A2B2794F868278FAAB606DA3598F42A19AA80E0AC7DC353B56
      0AE76F4CE6C74AFB994CEA62C8FE49FE4ABD293DB5A473168CCD4631439656FA
      8EE0781E2D3BF86D57D6D3988E38B4ED1FA6F5A5B8B5A8B8D3CDF712983A4860
      F61F48F483D86B876A4D7B1EE8E56E591A68E6F0E91C5A7682B32D0050B4D5A7
      61FD37AC4C81CEB42D486D5771AC0C91CEB1112BB8D60640E06B2512BD62C13C
      5695052094AD2754A93C0823B41AC941298DC1CD7508C41AD08576D008A1D8AD
      B847B565B19568C81A4373569E98B715000289E4973D04FA7DFAF507769DEF3F
      332CF527E2681929DFC049EF3FE9715A1732727B64619AD8785BEFB7D1E45067
      76B6A26E3536438DB0432092081C34AF5A69FA83666ED5C5EFAC4C4547079B53
      4A2858D083C6B2F5AAC5D128791A8A25554A5540965F214A884BABB2814C945F
      314A514BAFEF522A8826A22101CE5EED2A74057234A51097573A08A02FB7DB41
      4084791A0990E94ED45068265551455514446F9D1081590455454D349E544205
      113F7E982529814420532DF234E1532984510814D279D304A5308EDA64A5329A
      212959CB34554C9B1D948D7A96011EED2C8EA0AA8C6D4A9D12EE91365F64AEF9
      D774CFE5A08431646DE48505485F11F14F3D003581B5845F5DE57FA8D05CEF78
      78CD1656F1F2410C71406934CF6B1A695CB5C5EEA7C96071F0D144F4F9E5DE20
      94EB02C40E9C7FAA8FE0ACCFB16CBEEFEB39640E93795C2F5F4FD9C7E85D6364
      BCE8671906E5E3960CCA2DA5AB25E1C545538C474A141E58D1B24E8391E35AEF
      38688E1A1DF3F4C652EE385EF8AA4B81730662DA1DA4B6B97A68ADA775D69524
      3712CE6587B56B25058D6E5648728782DC7AAE22BD0BEA3B4B529454A5752947
      52AF4D7CD1B3BF7DE3FB791C5CE7F58938924EDAAEDE5A1A28DD8B331CF2ADE7
      4E94056920513F7E7CE5619B3921EC6ECB1865D9A2527BC80D2F48F195CBF0CB
      1CC8ED02BD2FC85DD85C6A3032F2FDC6181C2AC681F6B237E350E0C61DC5D89D
      A02E77A87334D7333EDF4C635E5872BE5792218DDF1453191E37B5B837E1386C
      5F3E721F3E7E61AF321C72DD7B818DC552896E2C38A85748F475AC126BB8D9F2
      7E8D68D0196F9BA5EE738F9881E65893A75FCD8CF7D257846D646DF15439DE52
      90B4F9E9F3276B7D0EB997C5BAB493AAE34C86D292A1E8D400455E49CBFA5C82
      86DDA3F54B9A7DD53D9172CC62BE9C1F9591E3C85A3DD53C7CBF79F6B0EE2DD2
      0E1FB956D6711C967A8356EBBB2A2604974F0083D5C5B27DBA5689CC5C82446E
      9B4F25D9454C6EF5A8369611EB53E2EDE1555E2D72EF4D206A395D092076CC04
      0693B3B661AE40766704B2BB68BE82ACF3AE2370F056F6D514B74B32DCB77772
      16DDEDFF00EAC5BD3130F6F259F79BF312A438B2F4F72188EDA63388012023AB
      53AD739E7E769967670DDDE4723DEE90C6D3196B4801A1D47660730C70E0AF6C
      DD239C58C38705AFAE3F991739E49B703D96DB9FD7D71F9B55E5B97D686EBE9C
      7FDD5936C7703784B9B5F98857F4B90EDDB9AF67E4FBA27EE3F4B0EA1CACCDB6
      D767FEA463FE54F5BA1B081E2FF8AA307CC0451DF246D9DE948E3E05D6AEF17B
      CF577C1C73A75F4949ACC5B7307283480EB1B8038991AFFABD5AA05D7C3E18F2
      2731FDDE82ABCAF06CDF0556DDEE62E2BB2EC56575C44EB5DF19640EF5FB45C5
      29487BB907A9C656943A94F1E929E35BB48ED159A63F52D398C963610D20B292
      46F77A9DAB0D72B6BB1E09638E15AE0A5A4F34B308657115DF5DC812D6A716B7
      1C575B8E12A5AFD24F126B9B31CE712E76D389F0ADE63006036270B70B31B6AF
      1BBC84AE67414DAA5AF9AB41C1A51F4FF24FB95E94EE9BBC57B5CDD3AF1D5DD1
      B8FF0061C7FB27E6F05CF79CB959B231D7508FD61FF30F7FCAA016E96DDCEC6E
      E921298EAEEC295A682BD636378D95BB570BBCB531B971279879B490B6D49F68
      AC8D4156342B1EAA85304BAF952A212CAA0532557F2A94A64BAFEF5227405544
      420AF97BB4A9D2EAE54A510973CCD045057DBEDA088413CA822ACA53B5108341
      32AA8A2AA8A2BD1F2A8840A7D1C855454D32D1E07DB44205193CE982528C8EDA
      640A6DBA21214C239D304A9A4FDEA60814C23EF51485329A60815D8F6931F72F
      37E889082B1DE0ECF5D58DFCD91855D59C59DEB65F3BD97A585E15B5901DD18B
      3C7172BCB693C0BAB03A1247BDF0D1D060C96E653B6477D56E03CAEAF9164ECD
      BF89D51F27C0B66646FED65EB3CFCD8C347CE2A0336D3AF77BDD365CEE1B53CF
      74F1E96D1F2947D435ACD004EC5B0492B23CB9C8199C1A3A5C76347494489364
      5B6642B9C45144AB6BEDCA8EA0743D4DA82BE114F14A627878DC6BE11BC78C60
      A9DE5932FADE4B693D591A587A2BB0F89D42BF42BB4799C7CF36FF0016C9D874
      38AB8426C4A20F279002560FBA35F76BE63F795CAE39539AAF74F60A441FDA45
      FB19BED194FD5A96FCD5B4F256A8FD474989F2FF008ACAC727ED22391DE5A66F
      01580F315BA6BDA8DABBE5FE22FA2F131260D9C83A10EBA082B1EB48E55D17B8
      FE578F9975D6B6719ADEDDBDB48373B29A46C3D0F7D2BC402B19CF7A94D6D6AC
      B6B67659AE5E226BB7B01C6478E96B0123A68BE054C992EE33255C6E0FAA54F9
      CEA9E992567552D6A3A9E27B07215EF17BCBC971DA7F4F20DC162AD6D22B4859
      042DCB1B051A3DF3C5CE38B8EF2BA86D46CA67FBCD747EDB855A8C9444FF006C
      B839F1596FD454481C3D66AD2F6FADAC21EDEEA411C75A02712E3C1AD18B8F1A
      6C58DD4758FC34ADB682274F70E19BB3650656FC791EEEAB1A7757176E0B77DD
      9F2B1BADB3D6D45EB22B73736CE7FA59D0C87128ED3A94150E038E8743A71156
      FA66B561AA077E0E60F73454B482D781F1B29DA3891B15AC5AF4D0CEC8350B67
      5B990E5638B849139DB985EDF51C7766C0EE51B7BC00A54878B4E21416CBA856
      8A4A93C52A491C75078D64838B4820D08D8B647441ED2D7B6AD2087023020E04
      1F0AFBF5E4DB77E66EB6D05BD37C754E64F89285AEEAE39A85BCDA07E01F20F1
      3D491A6BEAAF3D77A9A20D3AFDB731B72C7700BE94A012034900F09EB78D59F2
      75D767DB69CE7E736EE01A6A1C4C2E19A3A91BDA2AC3FAA8D901D7CD349FFA4D
      13FC71FAF32F7B6EAE896BFEE1FF00E585D0B4CFF18F817514A7AD4948E05474
      D6BCF44D05567C9A0AA8D767DFACB72966E171C37CBDE699558215CE7DA99BF4
      4976A6DA90EDB64AE2BEA6D0F4842F4EF1B206A05760677413F671BE4BE8185E
      C6BF2912540780E00D1B4AD0E2B10755C4D1A7F4F1AEB78067D69DC3B2C8BB5B
      60DC6CD2ED939FB56438E5E18F0D70B65C2369DEC592D6AA0140292A0524A549
      2140E86B9F73272E5D68177F85B9CA4968735CD3998F63B639A7860410710450
      AC85B5CB676D42E65E68ECADCED96CB323615E1723DB46DBCCF0FBBA783B12E3
      68507C290A1C4075B0B6963F8C85106B3BDDADE1875D82038C5724DBCADDCF8E
      51971FD5751EDE0E682150D40523CE36B711E2586C9770314C6EC568C9F29BB3
      38F5B6FE88A61A9D438E753F3190FA58421A4AD44E84E800ECACCE9DA25DDDCE
      FB7B66191D1E6AD081D561CB9892405B68BE8A085B24AEA02B9C3BBF1B4DD495
      359A80B49050A4C0B80208E44691EB6487947588C87086846FCECFEF22DD76C0
      8A190790FA16FF003B77362F3FB0DADE5DF9CC9F2494D12BB3E3B6F97749AA6D
      0A5B7E21D8F1595AD9492820F7A13C7957A739639CA4B5D3C3F5522DE461C8E3
      210C6BCD010E69268EA838E5AD0D5724D7F4385D707F0C7331DD66D3774788EC
      AAE592312DAECD172EDB8C5EFC3646C36A75DC5AEB19FB5DCC2073508931B65C
      5A47F29008F5D745D279A6DEF9A1F048D91877B5C1C3CA095A85DE8863188A28
      9B98E3CE63F717E22C6850A22B74826ED0556B334590D168EBE66ABAA412CBA8
      8A597CE90A212CAEDA5551057C8FB282212EAE54A530405F6FB290A708151440
      51E27DB413042573A05443572A529821D0455545159A9A8A223678D10815904F
      60AA8A9A61B3D9EBA8A238E74C12A2A4F1A74A9A41EDA294A65279516A429949
      E1EE53840A3A4F2A64A9D6815AD08038AB8544B453C7CB96331E04791915C521
      B856C6172E4BAAE410D24AD5C7D82B5CD4DEE95ED899B5C401E359AB5732D627
      CF260D634B8F800AAF9B9BB19948CFB71B2DCA9F595A2E13DC4C407B196D4529
      03E1ADC046D8808DBEAB4068F17A4E2AF797AD9F0D8B1D27F892132BFF005A43
      9A9F35B95BE25D23CBFEDD3B9CA371DFD346E0E3B2586CF4EBD4B58EA281E8D7
      41C6B5FE63E6DB5E5B6DA3AE0545DDD476A31A65ED6B99FD3930C3A56039BE1B
      9BD9238AD9D475AB1D7AEA0AD7B121AC6F466ABBC8A3A969C614B8EE8E9763AD
      4D3A93D8A41293F72B6392331B8B0ED048F22DD629DB711B6667AAF01C3C0E15
      F7D7D48F2099D3B3ECD906DDBAA53F2AD8EF8EB5B3A8D7B95F0569AFA387BD5E
      52FEA7B92E7BF8AC358B46667C64DB4B4F88EFB485C7A1AECEDF184795EEDB61
      AD4F6CE348EE58266FED59464C074B8647F9517FEE1F2E743B06036879684B73
      253CFAD96C923E2E80751ED3C2B35FD3472FCBA769FA8CF31699247C2CC31CAD
      687388AEFA93B951E6799B71CC568C15A4704CFC7E338B580F92BE55F2C09D01
      3E81AD7A415D3454AFBC9E44B1E8163D83B1DC23B0844DBFC97E4CE9000EA5F4
      AB44827D5C6B82F7B3A8BCEACCB7AF56289B41D2FAB9C7C782C7725442575E5D
      9F5E4B87B6BF222A318DF00A1F2A93D9DE256DCFF12BDE2176516E15EE396572
      1290A5B4AD414B880AE1AA48AD1B43E619748BE8AF22157466B43B1C08A169E8
      216C3AEE8B1EAF66FB590D03A94236B5C082D70E90402A3E623E4CB617114B4A
      462E6F321AD357A72CA8123B7A53A7DDADAF50EF7B5996A2DFB381BF2180BBE9
      3EA56BCDE41B79CE6BE9E7B83BF3C8437E83328521AC78C6358B32B631CB141B
      2B6E8487444652D9584FC90A501AAB4ECD4D737D5F982FB53766BB99F291B331
      AD3C0360F12DAB4AD0AC74B696DA42D8C1DB9452BE13B4F8D476BE9D7CD249FF
      00A4D13FC7245729EF49F9B43B6FF72FFF002C2CFE9DFE39F02EAA85742D2AD3
      5E920E95C05C2A28B3AE1514518B07C27CC5ED9D9E7E2B89647B6F3B1D72F778
      BB5BE45DEDF7454C4A6ED39D9A50EF72F2504A0BBD3A8E7A577C1DEA68B24710
      96D67CEC8D8C347B284B1A1B51515A1A55610584CD272BB7AEABB6D84DCF0F81
      7E9391DFD1946639A5E5EBFE5F7B623F848CE4C79B6D8433163F52CB6CB2CB48
      6D014A2A3A7528EA6B987397349E61BD1388FB28D8C11C6CAE6218093573B0AB
      9CE249C00DC1642CEDBB06E26A4ED5C0B7E73A81B9CF5C7CB56DFDC5AB9E477D
      5309DD9BA30AD59C731C43A95CD2EAB875499294F70D369D48EA2A568056DDC8
      DA14BA364E61BF616C31D7F0CD3B6E2E08223CA37471939DEE34F54015AAA72F
      FAB905BC78E233740F49D815B9FF0074DE69E5EDA8C8EE63B3B870DA8ED0E486
      916F948427DC4802AE749A9D3B542EC49B5713E132309F3ACD6BACC90C407C71
      EE1532C48782B52B2403CB871AE3263691B15918C5362E53B5FB618AECF58AE5
      6FB2F72C4CC92F336F794640F7432F5C6E57190E3EA538B2413D017D0DA75E09
      1C056CDCC9CC777CC370C926A96C71B638D82A4471C6D0DA01D34CCE3BC956D0
      411DBB4D769355CE72C910B32DE743B2DB6E4D8361AD0A98F485A428AF24BEB4
      50C361CE7FD5A1052CA75E6EA0F60AF4DFF4E7CAEE82CA6D4DE0833BB2306EEC
      E338BA9F29F803F256B1CC77607506E503B762F0D5CF2198B6B4E92E13C3DB5E
      C9B28F2B02E4F76FCCF5C8146AF8AB409759E268264B28F334A5109651E7489D
      05678544C0202A94A212EB3CE913A01245451015CCD04C10F5D682886BA52982
      1124504579A9A8A2F2A2888DF3A2102B2093C01AA8A9947473A8A2601E468A54
      50791A74A9841E1EDA294A6926884A53093D95502528E934C82D9B1A84A9F748
      ACA4756AA1C3DDAA52BB2B4A68DB57514D8DD6BFA76ABCB95C10C2BB8BC65A13
      6D840705742B42E11F00F76B13A3C7DB5E3A63B2315F9C706FBE7C4AFB538BB7
      6C1603FF005DFD6FD947D793CB46B3E72F93691A0009D48E67D26B685B79352A
      506CAF983B4ECEE3D32D2D622EDF275D5C539739AB5A5093AEA3A10071E9D34E
      75CEBBC6EEC6CB9E5B682E6F27B7FC29739A226B1C0C8E20890E6DEDCA0368B0
      56FED6B1BFBAB98196D23276B180485E1CD8D8082DEA8A758B892A3F65372B75
      E722BC5E2D511C8106E921529B82EE854D29CE2B4EA9E1A7572AE9323B31AD49
      3415276B8800171E976D3E155397EC67B0B08ADA72D2F6022ADAE5CB525A0571
      EAB70F12EAFE5BB705EDB6DE1C52F81CE8852DFF0001714924254DBDF17E37BF
      580E67D19DAD68F7760C00C92C4EECEBB3B6675E3F2B865F1AB7E6177E15916A
      036DB481EEA6DEC9DD4947D139BE6A9B9FF70C6C5E71AC02FF00190AEE61C875
      A7CF3480E749490A1CC1D6B847F4D3CD516AF65A95B6431CD13E27B98777AD1B
      A9D01C298E216539921EC35FB39AA0B25825603C4F5641E5155F2B48D411E91A
      57A495E8342BEEF7919C8A25DF606C10D8752B936393222CC681E28255D49D47
      66BC6BCE1DF344F835A8E623AB2C0C20F12CAB5C3C5879559F24111FE32D8FAD
      1DC3CD3E4CB47B4F80D4F91481DD7CD5BC0B6F32BCA152910DFB74077F27BCBD
      0E9256921AD01E0743C74F5569BC97A5FB6F59B7B322AC73AB27444DEB3C93B8
      530AF12B2BCDDAABB4BD3259A33F6B4CB18E323CE560037E26BE25F37B03FF00
      B8F5C5A0C45DC3C3132DA07A5577B62FA56A4EBA05A9B3A8D48E27415DAF58EE
      7B4BBB25D633C96EEDCD78ED63F2E0F1E75AFC57DCC160007F65740015A7D8CB
      5DE31AC6EA7CDAA9F3B4DBED816F4C29B2F0A992242AD811F94987DA282CA964
      8092AE209E1CB9D70FE72E49D4796723AE8C6E8E42431CC75438B713D5347369
      5DEB64D0F9923D4E57C0E8A4866600E731E29D57540707025AE06868415A05E0
      EBE68E57FD2789FE38FD717EF2493A0DB7FB97FF009616D961FE39F02EB084F5
      A929D74EA3A6B5C289A0AACE13415519F1BDE8DD9CDE1CFBCE0FE5DDDBF6371A
      EF72B443BBBF95DBE12E42ED729C88EB9DC3AD152015B67404D76B8FB9E8FB38
      DD26A4C6B9EC63F2F62F7533B4380A838D2AB0FED279268CD8B7BDBBDD55E657
      9BF62191E1974DB9CF71B8ECCEB862B747589497A0485A9B6E64397194A6DF6B
      BC4142B9292AE047115A0F32729BB488D93C73B2E207B9CC0F68734B6467AD1C
      8C7F598EA6236870C4157D05C97BB2BC51DB7C2125BB9B3169DCAB6FE50B33A9
      C43742C695CAC13712DE90CCD873903A9B4485200F1119D2021E65CEA4A904F2
      3A10DCADCDF3E8B2E497EDACDF84D03B163D87696D7D491BB58F6D08701BB042
      E2DEBD761CAF1B0FA788E21463839A3BB808F2B9954B809B4DD6E19FB0CE4169
      6C9288B73871A6C59CCA09E3D297DA574EBFC5D2BA7DDE9234B66B16CC767636
      D4963B7BA37BA37C6E3D258457A55E5FDD7E2ACA090ED2E15F0E20F9D7D053CC
      D701517CFBCD6D96ADDCDDFDD1979B45FD62C6B6DE5C4C4709C6A4BAE08119FF
      000A899739FDCB6A48548716F25B0B56A5094E89D3535E81E5D924D0B44B3168
      7B39AE43A695E00CEE6E62C8A3CC41A31A1A5D9460E73AA55DF2FE9715FBE492
      719834E500ECD98F8F1F32EAC71AC6F0FD97F0583DB9DB7312A5C99379EFE4BD
      31F765AB44A96B7E42D6E28742501209F8A9000AF53F76DA90D42C237BA99855
      AEA00D151BF2B4002BB766D2B9B73CE9DF80BB7C6DF54E2DF01F46C5F396FCE3
      8AB9492E93D5D675D6BB4C7EAAE52FDAB5E59E74E5009751E74114BACF3F5D29
      4C12CA3F0D2A6082B3D941320A8F3F55294C12EA3F0D2A6403CEA2882AEDA053
      042A5510D7CFDCA053043573A08AB6A28AAA2888DF3A21429F4F214EA914649E
      DA2A2653CA8840A2034E12A61B3C8514A53293CE88DA94A65278D3A54749A609
      5484D8CC5DCBD641155DD95243838E9EBAC66A53E46157F610E77858DF3B199A
      2E39C5970182E8540C32127C5369E5E25CE7AFAC71F7AAFB4683B1B4693EB487
      39F06C6F9B1F1ABBD29BF8ABFB8BAF831D20678BAF311F38B5BF35434830A4DC
      A743B6C26FBE9B70792C446B5D029C59D0027B07AEB2AD6971A0DAB377977159
      C0FB898D18C05CE3B4D0701BCF01BCAEB83CBD6F19F9386B8AF414B808FB95AD
      9E73E5E068753B3C3FF7D8B1A35C04022D2F687FFACF5AB659B5F9E60B0A3DC7
      2CB0AAD10E53C188EE2961454B235E5A72F5D64B4ED5EC3536BDD65730CE1840
      7764F1264CDEAE6CBB2B434E2AA5AEB50DC5C0B731CD1C85A5C04B13A2CCD6D3
      3652EDA454542D0D2B75A521E655D2FB0A4B8CA8730B41EA4FC22B24D7B98E0E
      6ED06A3C21651F13266BA390558E05AEFD570A15F5E62448FE633CB55BE28587
      6F0D4109655CD425464E807B48E1EDAF17DFEA50F759DEACD7127534DD45B99F
      C191DC1AB9DFF46E0127830958BB6B1BAD5B971B145D6BED3652D68F8FD8EC6F
      FD681C003BDCBE4A5D2D73EC9729B67BAB0A8B71B7385A94C2810751C9435EC5
      7315ECF229BC11B4118820E21C0EF04620ABCB1BE86FA065C426AC7ECE208F59
      8E1B9CC38382E95B57BDBB87B353654BC26EC23B13F4F1D6D7C75B0E11FC6E93
      C35AC6EADA358EAF00B7BE85B2C60D403505A78B1C3ACDAEFDC782B3BDD204D3
      0B98657C1381973B287337736463BAAF03E09DA3715B1EEA7995DD4DE180DDA3
      2BBA34D5A1B3D4BB7444F76859FE769A7BB56FA2F2DE97A235E34FB71117E0E7
      54BDEE1F1733B10DE814AEF5462D11EFB865C5E5C3EE248F160706B2363BE386
      3702FE0E7569B9704016A5210DA14E3AE282196503552D6A3A25291E926B3401
      71000A93B02CDB9CD634B9E435AD04B89D8D68DA4F817DDDF27BB532B6AB68E1
      0BBB1DC64596382EB76688F8CDA569FC1367D893AFBB5E54EF8F98E3D53566DA
      40E0E8AD5A5951B1D2B8D652388068CF9A9F92EDDF389B529016FE21C3203816
      C0C1962A8DD9855F4F94B2D753AF9A1907FF00E4B0FF00C724579EFBC91FFE0D
      B7FB97FF009616F763FF00C8778175C42BA56951E21241AE12E151459A70A8A2
      8A385E17E6736CED571C5B0FBD6D7CFC6D77DBC5DED8FDE61DD953426ED39D98
      50F165D4A094173A7548ECAF4237BD3D0648A2135B5CE76C6C61CAE8F292C686
      D4545686955841633B49CA46DE95D136F76F730B765B90EE66E76516EC973DC8
      2DCC5922C6B1425C0B45AAD4C3AA7FC3C66DD5B8EB8B75E575B8E2D5A9D00000
      15CF39D39CADB59636DECADCC3035E6476676792594B4333B8801A0068A06B7A
      49DAAF6D6D9EC39A43534A0E80BB04A9D0ED71655D2E525B856EB5B0E4CB84D7
      4F4B6CB0C20B8E38B3D81294924D684C85F3B845182E7BC86B40DA5CE3400749
      2AF24706B493B17CD0DBC0FBD6CF2DB7A7985454E65BB33F28851560A5488978
      5DC65C5D52797532B4AB4F5D7A47984359ED5841AF6362C849E2E8844C7F91C0
      8F12A52445BA7404FC27D7CB988F315F4E07CA1EDFBF5E6BDCABEE5F3F3185FF
      00C4FBEA4FCA56E7DDF53E9D234503E0AF434CDFF43A6FFB38FF00B4E5B2F270
      FF004F27ED1DEF2EE38A74DDB14CBEC8E0EBEE52DCC641FE70285E9EF0AEC9DC
      FDF163E680F4387B87DE5ABF7A3620C714DE169F747BEBE7167D0BC0DF653613
      A7E115C3DDAF515B3B33179D2E1B472D05479D5C2A480A3CFD940A812CA3C452
      14E100D04C105475341320ABB690A212CAFB9413142351440576D294C8741443
      573A053043573A08AB6A28AAA2888DF3A21429E47C914E15228A390A2A265079
      D40A1451CE982428C83C69C2056560417E73C9658415A947400507383506B495
      DEB16D8DC86FCD21D4C470A5438120D63E5D498CDEAF23B073D7426FCB2643F1
      7FAAAFD7C2A87B659C557F65B94B1D96D98BAE271E54C66DFE26E4CB0B5418CB
      2101C7824F424A95C06AAD389AC3DEEA0C99E038D1B5153C06F59086CA586273
      A36D5E01CA3655D4C31F0A8A595F908F30597E4D7CCA2E136D1E2EF929729C42
      9F428A02BE4A35EBE3D22B6C77326995C25206C1D43B0601623481AA5859C76F
      F81CC5A0973BB66759EE25CF76CDEE293C67C966E2ED7E638C64B9AC8B748B53
      1216511E338952CB8900F570279035A2F785DE6E99A0E8F70E8E471B99629238
      4061A768E6D3313F04341AD78ACD5AE89AAF31CB15ABAD445009637CCE32B5DF
      64C7662D0D02A4BC8014D861C3C069CABE721B7635A0507997A4DE0AE51BEBB7
      13374F047B1FB696DBBAA1F43D01F7B4094281E24EBA7BD5D93B8BE7FB0E4CD5
      EE1DA838B2D2E212C796B4BCB5EC21D1BB237138D478D735EF0797AF35065ADC
      D9303E7B7973652E0CCF1BDA5923733B0151438F050AC792EDCF3A6976B5EBED
      3FC35EA13FD43F230FDEE5FF00C77AD10E9BCC7FFF00307FE447E852EFCB4ED8
      EE06D146BCD87247A2CEB2DC17E2A13D19CFE81D1CD25049242B52785700FEA0
      79FF009539CF4FB376993BDF776EF70A3A27461D0482AE199D8755E0380E92B2
      BC9BA46B36BABCF71736A218668DA1DF6AD92B2C7835DD5E2C394F802CD6F3F9
      6BC4F76966EEC2FF002064E94902E6D27E2BBFE900F4FBB586EEB3FA84BCE55B
      7669DA9C66EEC998308752E206FC5639DD59231BA37D29B1AE03057BAEF21CA6
      E1F7BA5482295E6B246F1582677C67018B24E2F66DF840A8497AF261BB76E794
      9B62EDF7A8E09E8752BEED447A48AF4FE99FD40722DF3413A8184FC59A27B48F
      1B439A7C456A92C7AE5B1A4FA6BDDF2A1918F69F007163C78C2F2DBE4977E6E0
      F36DBB6AB75B5A5E9AC97E5B7D201EDD3A856D32F79DCA91B33FB4627022A320
      7389F1502B36DF6A521CB1E9B393F2CC6C6F9731F714D6D8AF24D8DEDEDCE265
      59F5D2365B904321C836E469E0E3B9FCA3AFCB23D95CB79BBBEA65CC2EB5D1EB
      187021D33DCD1250ED11B013D9D7E3125DC28B276DCA97BA939AFD50B5B10208
      823A96B88D9DB3C8064A7C40032BB6AA779791FF00888D3900149FE1AE0ED746
      060E6FD21E95D15B1D0500F328ADB8577BC621BF51B3046DFE599963D71DBA62
      C82E18B5B85C833399BABD214CBE0388E83DDA828558F34682FD7B498ADEDE68
      1AF64EE791248D6754B03411B6B8AA0C90C131739A684704D9DEF50E7B27BB23
      FF00AC9FFDC573AFCA8D4FF88B3FFBEDF42BDF690F8AEF22F0EF8E9CF65B7607
      FF005AFF00E451FCA6D53F88B3FF00BEDF423ED11F11DE4287FBE9BDCC3DDD93
      60B736E2F9E09F1B6F836A6B5FE73B326200F6E9571077457EE3F697968C1FB5
      CFE66B4A53A81DCC7791724CDFF793BC8838DE73688FB6BB649792720C2E1DC1
      370BCDF834A0AF093E6470188D114A1F846DA2A5383E2950493AE4B48B3D3796
      25335B3CDCDEB6A1B239B92180EC2F8D8E25D24A3E0BDD46B7D6009A2CCDAE89
      717843A7EAC7B728C4BBC3D1EEAC2EE348976ABBED2E470F1DB95F2DD86E6316
      E374B658A2F8890CC26E23EC82D47494EA9415A468390ABFD1A16DCDB5F5B3A5
      631F340E6B5D23B2B4BCB9AEC5D8E2684D5657986D2475BC6226176578C00DD4
      2BAD1F33D8B2482ADB5DCD1C75E38DAFEBAB4C1DD95F1D97567FF7C7F75607B3
      BB3FBBC9F47FE2A3DE132665C24EE764122CB73B047CB33AB9DE6D102ECC7859
      661BECB086DC719D5453D45074D4D74CBE85B045676E2463DD15B3237161CCCC
      E0B8901DBF685B9728DA4D15B3BB4639A4BDC684634C1483DA169C9F935C2D69
      048B85AE424A7D682858FB95BBF7693F65AA538B0F9A855977896B9F4BA91B1E
      3CF50B916E2F977BCDD2F5224B119452A7144102BD4B6BAB35ACA12BCD371A6B
      9CEAAE727CB1E427FDD17EF55CFB619C55BFB2DC84AF2C5909FF00745F2F450F
      6C311F653961EE7E5AB238ACA9DF06BF8A0F65166ACC276A0ED35C028FB9361D
      73C75E5B52D85B7D274E22B2314ED9060ACDF0961C568EAE00D572552082A3C0
      553298202BB6A22846A2880AE54A532B35A08A12B99A0530562B9D0515B51455
      41157A39D10814EA4F215502428A398A29519279D451300D14A8883F0D302810
      A5D797EC1615EA689F71E94438882FC8757C92DA0752947D400D6B0DAA5DF64D
      2B236713685EEC00153E00B3FB87BEB912AF332CB81DC158DE316A7551A1BB0C
      250FCBEECF4979C774EAD1446A948D341EBAE6379A94B2BCD0D02E55CC5CEF77
      3DC3A3B5798E269A0CBB5D4DE4F4EE0B9EFEF9374FF6F2F1FDA15567F8997E31
      5AEFF346A9FC43FCA8EDEF6EEDB5FD16E15EDBFF002652C5033C87E1147F9A75
      41FBC49F48A3FEFDB78FFF00D26FDFDAD7FC343B67F12A7F356ABFC4C9F48ABA
      EDB85BD372B1C0C86F192E472B1D7A5B90ADB7990E3862AE5200538CB6E9F8A5
      600E22B1F7F616F7ED68B98C4801C330A8077D164E1E68E61B587B765C4CD638
      E5CC0900918D2AB56FDE4670900FEB75C40E40F883CC562CF2C691FC345F4429
      FCFF00CC27F7D9BE914CCADC2DC5B7BEE469D94DDE0C965412F467DD5B6E2144
      020292AD083A1074340F2AE8DBED62FA21349CF5CC4C716BAEE6046ECC50FF00
      7A19FA4849CD2E6951E40C820F1A0794F45DF6917D10A9FF003E6BE7F7C97E91
      5EFEF4F70027AFF5DAE61038757893A6BEDA5FE52D1295FC243F4421FCF7AFD6
      9F8B97E91577EF537092124E6F74485FC92649E3ECA0794344DF690FD1087F3D
      6BC7F7B97E9159E4E57BD2E595590B77AC8D561485955E42DCF0C3BB5042B573
      9705280F6D1FE4FD1695FC1C54FD50AF0735F3298BB6FC44D938E634C14B9C62
      FF0071B9637609AE5D1E7E449B747724B9DE6AA52CA005295A76922AE9BC95A0
      103FD0C1F456F963CD1AA4B046E375254B457ACB71B6C2CAAF2990BB445B95D1
      113FDA571D2A5A51A8D742476E9D9CE9C724682765843F4164A1D675A98131CF
      33A9B6856B376C958B1429171BDDE956D871B50EB8F3852AEA1C3A1283F194B2
      780481AD07726680D1536300F9AACE6E6BD460697C9772003E57BDC7A145ABF7
      984CC1DBC2DCC7277E4AB3B3AA18832025D71E039B8FEA7828FA13C855ABB94F
      43AE16500F983D2B49BAEF335C32561B990306CA9AD7A4E0B276FF0031F794A5
      06F56B6A5215A0F11124B8C13EC4A8A934C395B43189B183E8AAF0F7A3AC8C1F
      3487C0EA7BC56FB6EDF8C36694B73E65CACEF2B8692125D403FE534A27E0AAC3
      95F41069F82847CD59783BCCBC906375337C26BEE2E8D62BFD8F2E123F57AF51
      AFC61B0B9331B61F0A5B4C234EB71695105294EBC4D568F957437FAB6909F035
      672DB9CB549EBD95ECA682A68ED8389E85C777523E6AC5DEC92B10B95C24B77F
      75BB6A2D101C2E1F1A47E092DA104F1753C87A452CDCAFA50232DAC7C306EF5A
      FEB5CD3CC62463ADEF2639CE5A0793D6DD4A715C8ACB3B76725BC3D8FE3EBBF5
      EAFB1FBDEFED30C38EC84772AE977A909E23A0F03E8AA6DE5BD34E02D987E685
      81B5E73E6CB994C315DDC39E2B8071270DB820E4B3B74F0F9C9B665CABE63970
      5B61E6E25C838C2D4D9E0149EBD011EB144F2F69CDC0DBB07CD08DEF3AF36D8B
      F24F7770C76DA1710B5A39AE48B2906FF254A50D520BC4923D5C688D0F4E1808
      59E40AD47793CCE3F7F9FE99599C7335DC04DEE1338ADF6E432096E08901A82E
      9F10E38F7C40DA403A92AD74D2AEAD74FB5B7933C31B5AFD980C71DC83F9EB99
      AFE903AF277871146971353B96CF73DCADF0B5B31655DF29C8E0B13DC90D4291
      25D5A12F2E239DD484A147E516D63A55A723593FC44A3E1158FB8D6F5A81A1D2
      4D2806B4249C729A1F21587FDF26E9FEDE5E3FB42A8FE265F8C55AFF0033EA9F
      C43FCAABF7C9BA7FB7978FED0AA9F8993E3153F9A354FE21FE5478BBD7BA7124
      372139ADC6416C83DCC95879A50F4290E02920D16DDCAD350E2AA45CD9AAC6E0
      E170F34E26A3C85770BC3D66DE1DB87B276E0B50B21B4E91F228ACA746C3C428
      A1C6F5E4970275D3B388ADD742D4CCB81DA1763D075966B767DA91491B83C0D9
      5DC4787CCA005E237829B223F2E85115BCB5D56D5339B42B0CA3A8F651510546
      A2882A3C6822104F3A545094789A053056D04558AE750A8BCA08AB35345057A0
      9D6A289D49E34E122324F3A294ABC1E3454460AE5510476D5C7DEA20A8429FFE
      5C1F44BB2DF2DCC80E4C9D6B951E335DAA71C6549481ED26B58D7584B0D382C8
      C4D325BC8C6ED2C701E120A8BF758722DF74B8C096D298950A4BAC4965434285
      B6B29524FB08AE5EE14345E6EB889D14AE6385082411D20A4282A2AAA28AE421
      6EAD0D36A4A56EA8210B59E9482A3A02A27901AF1340D698278DB99C029D17CC
      83696E5855E361E0E72E166CD8AC76B1D96EB11DAB0FEB25BBAE73B359B87785
      C2B94B756C9D53D2790AAEFCA586307761C330C6B5E95D6E7BDD324B57698D9B
      06C632EC1176ADABCB83AB5ABC9737650F916B7773B6706CF95E63699388954C
      C57117B0FB3214CB9359BAC292C1BA28C3D3A90BF8AAEB078AC7A46B48FCA039
      C29B1B41D3BF056B29D3591BE763A2C638B2014CC1ED2DCFD5DC7035E2B7EC8E
      F989DEB3DDC1BEDAA7EDB5C326BAE416A79BB8E43E19CB7BB882D81E27B82BD5
      1E2BA81EFBFCEE9D3D34F29AB896E5AD46DD9977F8D6567BBB49AF2791AE80C8
      E7B4D5F4CA61CBBAB866AFAFF0B862B5DC6EF9B1F02E764B4DBAD789CAC36FB9
      2E5ED5D9EBE474392DAB3B4CF796B4179D21C65B5BA346D5AF514E83D3519D9D
      40006525D5AF0DDE01C158DA5E6931BDAC636231BA49AB9875B20158F1388A9D
      876AC5D86E981DE6762396BCE61768C98E04E3D7EB48890198EF5CDAB829A4A1
      B6A56B1633E98A015296852948F9292AE34911072B9D4AE5C4506DAF902A714F
      6334B1CED30B5FD892451B42E0F230CDD46BB2624906A360AADAE35B3039F7ED
      CB6F6AA06013A723234DC2EA8BFB49976E461FF9350EBEBB7A40D425123BC2E8
      6747070D3414F95A5CEC9976EFD9969BBC6AF638ECA496E3F042027B4CCECFD6
      6F6190125BE0757365EB6CA60B53B7B9B76DECBDCECB3AF58ECF4CFC6A44FB6B
      115C622C86EECCCFEB0C8696A54C71F4B04949594B64748092AD4D4193B3A546
      CF3FBAB1911B11A5BA37BE3358CB8528D21E1FB295CE5D978D1B4A505549290F
      E0B23072AC60D81561478246D90B3FFB62232001244E27E3EBCFAFBCE3D7CAAF
      016E5EAD29B96DB23ED1D687B1ECF2757B2C9EB53E167DFE1AEF5EFE58B32713
      C4587F36B7E10BB15C25BD72727CDF04A597141C4CB647F9F52123A7A7D3C2A1
      700054D1413C66DA20666C591C4BB33B2ED35CE3E3506145C62D39E61B99C762
      45FAEB865D6D2CE4F781B9B27266835719362D008522D4DB9F1C38EA413F82F8
      FDE69AF0AB53207D2B4A54D6BC375160ED353B4BB6E695F139BDA3FB52FC1E63
      C3298C6DA915F571CD4AE0B4FB4E4FB636AC4AD76F8F69C3E716F6DEED760E5D
      21B0FCF5E450E7ACDA9890E6BD45DEE7425B3F2F8F56A34AA4D2D0D1403D53B4
      639B757D0AC60BFD3A1B76B03613F60F762013DAB5C7203D34A61BF7ADC2C937
      661DC9B29BA34CE24ABDDD60E2B2DC8CFF008062D9DC3D142AFADC74CB4A9865
      65ED43A940EF123FA3E3551BD9E6270AE1C29D34DDE1DEAFEDE6D2CCF2BDBD96
      7736234EA86D0B7ED40CDD518EDA7580F556829C8366E1C1DB3B27E47C7D18A6
      43975E7F5FA477625DD625998B885DB9954BD12EA1A5248D5400529B1A72D6A9
      92CEA8A0A126BC69BB1FD3058B6DEE94C641196C6237CAFCFF0009ED6078C833
      6DA537E04847BC49C6D373CA5CC9E56DD78E7B06C998B39C3FA58475ADC6C5B1
      3214C90CADE2DEBDD2503AF4D7AF53530EB572D729F57CC9AEE5B7ED5E663057
      B1932F6780AE192B4C3353D5A634F5B15D1D8BE6DDD8ED7B7115BCA71B71FC73
      2FC4A643B85B9C8915B36E2D9F1EEA9868A9E4A10E7CB325457D5AABE2A74AAE
      1CD01A011811E4DFFA15946DCD840C80769192C96220B72B7ABF0CD0634076E7
      24D71C02E2BB277DB040DD9DD09575B9DB19B75F2CF9345B739739CA810A6392
      DFD596952D042DB4BA3F8C93AE9C45508681CEAEFCDD1B4F15AE72D5E40CD52E
      1CF7B435CC900CCECAD713B066DD5E85D4A5DFF6E5A9FB771AF72B12989C470F
      CAFA70A6AE2E5FAC7165AC0916F266CB25C71F90E0D0B6547403E2E94CC0C194
      1A600E15CC3A313BD6C3757F63DA43DABA27648A5EA66CF18753333AC712E73B
      6B6A760A51603199BB7973DB2BC49CA2461AE5C72CB0DFEE0FC262340B73F06F
      C93D70984A3E34B2E00356FBB286427E2E8A351994B3AD4A90780C7774FBCAC6
      CE6B292C1EE99D113232475006B4B64DAD6FC7AF0A656530C4ACCDDE5ED5486B
      6AA787311B1478394E3FDE596DEB87252BB7F7604F7133590D4B6994AB553A99
      69EAEAF92699DD9F5694188D9C37F4F95579E4D3DE2DDC4C4D0248FAA0B5DD5C
      3390F147868F842415AEC2B87EEF5E6C570C4F6E2DD65B9C5986D13F2BEFA1C6
      73AFC3B322EAA723750E2405B7A14EBCC55279AE5E8CDEEE0B58E65BA824B481
      91381CAE97007602F34F36C5C1295694AAA28AAA28A576CD21CB7ED4EE0CD98C
      A9A8B729719305F58D12E965B7439D24F3E92A00D6CBCBCC3989F02EC7DDB44E
      65A5C3C8C1CE6D0F1A035F2283B963A872F32D48E4567EED74D8BD55B44BEB2D
      58AB98AAAA9AB547854502028F1A54C86A3C35A0510847B69532B353A54510F5
      351455A9A8A2F2A28AF473A8A26C1EDA74A8A93C3DB450288934529570275E75
      14474AB4E3AD450AED7B53B852311BA46752E9420286BC7D7567776E256AB9B6
      9FB37297F9363380EF230DE436EB847C773193D1F946538B22349091A75B8DA5
      2B3D7A0E634D7B6B41D474371712DDAB0DCC3CA16DABBBB784864C769F82EE92
      0038F4F956A03CB4ACFF00CFF64F9CFF00D4D62FD893742D5FF2CAE3EF99E7F4
      2BBECD0BFDBFB27CE7FEA6A7B126E843F2CAE3EF99E7F42AFB33AFF6FEC7F39F
      FA9A9EC49BA14FCB2B8FBE679FD0ABECCABD34FD7EB1E9E8D5ED3FD4D4F61CDD
      0A7E59DC7DFB3EB7A157D9957AEBFAFD63D7D3ABDAFF00A9A3EC39BA14FCB3B8
      FBF67D6F42F7ECC6BE5FAFB62D35D74D5EE7E9FE8687B0E6E853F2D2E3EFD9F5
      BD0BDFB323BC75CFAC675E7C5EFA9A3EC39BA14FCB4B8FBF679FD0ABECC6E9E7
      9ED8CEBC4F17BEA6A7B0A6E853F2D2E3EFD9F5BD0B296FF2FB7DB4B33A3DAF74
      6D96E66E6DF737044775F6FBE6F8828510CEBA1048201E2381A9EC39F7157307
      77F7B007065C30070A1A176CF22C5FD985DFDBDB1EBED7BB3FF26A7B0A6E856D
      F96971F7ECFADE85DEB07DBE8F8AE350AC7272BB54A7622DE5179B2E74A838AE
      A0352849E155A3D22668A2DAF4DE5592D6011191848AF1DFE25C9F27D87BEE5D
      767AED7ADC6B23EF2894C56077E96A3B5AFC56DA4773A240F87B6A93B449DC6A
      68B037FC897B79217BE767831A0E8182D7FECC2F1D09CF6C648E4497F87FE8D0
      F61CDD0AC7F2D2E3EFD9E7F42F3ECC4EFEDF58FD3CDEE7F89A9EC39BA11FCB4B
      8FBF67D6F42F3ECC4EE9A1CF6C6473D357BEA6A7B0A6E853F2D2E3EFD9F5BD0B
      DFB31BDCFF005FAC9AFA757FEA6A7B0E6E853F2CEE3EFD9E7F42F3ECC6E0E033
      DB18EDD357B9FE26A7B0A6E853F2D2E3EFD9F5BD0ABECC6E71FF008F6C5C79F1
      7BEA687B0E6E853F2D2E3EFD9F5BD0ABECC8E7239F58C8F412F7D4D1F61CDD0A
      7E59DC7DFB3EB7A179F66558E1FAFD63D3D1ABDF5343D8737429F96771F7ECFA
      DE85E7D9957CCE7D63D7D3ABDF5353D8737423F96771F7ECFADE85E7D999435F
      F8FAC7F1BE5717B8FB7F0353D8737429F96771F7ECFADE855F66750FF9FEC7EE
      17BEA6A7B126E853F2CEE3EF99E7F42F3ECD2BFDBFB27CE7FEA6A7B126E843F2
      CAE3EF99E7FEEAAFB34AFF006FEC9F39FF00A9A9EC49BA11FCB2B8FBE67D6FEE
      A660797DB0DAA7312B28CD604DB3347AA5C6B7B8E21F581D8952DAD06B5522D0
      E52EC762B8B4EED4B6506E256966F0DAD7CE16BBBC5BAD6689688F88626CB76F
      B25B1AEE214464FC54A46BA927992A3C493C49E35BB697A68840C17413D8DAC2
      D8206E56345000A0FCA90A90FADE51D4ACEA6B63028B1E4D52B4504252B8504C
      10C9D682286A3CC529442193A7BB411433C8D45159514555145551457279D451
      36390F6532528A390A282227B68A055D450441C8545138C75FC5E8D7AB5E1A54
      41747B03B9BA129FC951643A9ECE9501F748AB7788AB8AAEC326E5B9A656EB70
      FEEC97A7FA447D3AA7483884F59B823895BABFA365FE311F4EA520E210266E0A
      F12B7534FCDB2FF188FA75290710A566E08A995BA9A0FEED97F8C47D3A602DF8
      84A4CDC17BE2B753F46CBF9E8FA7440B7E214ACDC11BC4EE97E8D97F3D1F4E8D
      2DF884B59B82BFC4EE97E8D97F3D1F4E9F2DBF1096B37057893BA3A0FEEE97F3
      D1F4E865B7E213033702AE127747F474BF9E8FA75296FC42959F815EF89DD1FD
      1D2FE7A3E9D0A5BF108567E05193277474FCDB2FF188FA7532DBF108133F055E
      27743F474BF9E8FA7472DBF10A567E0BCF13BA1FA3A57CF47D3A996DF8852B3F
      043F13BA3FA3A5FCF47D3A14B7E211ACFC0AF3C4EE8FE8E97F3D1F4EA52DF885
      2B3F02ADF13BA3FA3A5FCF47D3A34B7E211ACFC0AB0C9DD2D7F374BF9E8FA753
      2DBF108566E0AD32774B5FCDB2FE7A3E9D252DF884D59B82B0CADD2D7F36CBF9
      E8FA74696FC42959B814332B74F5FCDB2FE7A3E9D2D2DF8852B370562A56EA69
      F9B65FE311F4E8116FC4220CDC104CADD5D7F36CBFC623E9D0A41C426ACDC10D
      52B75743FDDB2FF188FA752907108D66E087E2B75BF464BFC623E9D4A41C4235
      9B8156995BADAFE6C97F8C47D3A5220E211066E05632E5277394D1126DF290DE
      9C495A4FDC554021AE054265DE1724BA1B897D5E3D2B4B9AF10AABB652982B67
      56B8AC2D3A55551440572A52995941442573340A70AC57650515879545159514
      555145FFD9}
    MostrarPreview = True
    NomeArquivo = 'satcfe.pdf'
    SoftwareHouse = 'Projeto ACBr - http://acbr.sf.net'
    MsgAppQRCode = 
      'Consulte o QR Code pelo aplicativo  "De olho na nota", dispon'#237've' +
      'l na AppStore (Apple) e PlayStore (Android)'
    Margens.Topo = 50
    Margens.Fundo = 400
    Left = 64
    Top = 344
  end
  object PrintDialog1: TPrintDialog
    Left = 608
    Top = 256
  end
  object SaveDialog1: TSaveDialog
    Left = 260
    Top = 280
  end
  object ACBrPosPrinter1: TACBrPosPrinter
    ConfigBarras.MostrarCodigo = False
    ConfigBarras.LarguraLinha = 0
    ConfigBarras.Altura = 0
    ConfigBarras.Margem = 0
    ConfigQRCode.Tipo = 2
    ConfigQRCode.LarguraModulo = 4
    ConfigQRCode.ErrorLevel = 0
    LinhasEntreCupons = 0
    ControlePorta = True
    Left = 97
    Top = 280
  end
end
