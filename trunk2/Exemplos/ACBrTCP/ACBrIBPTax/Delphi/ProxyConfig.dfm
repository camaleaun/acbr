object frProxyConfig: TfrProxyConfig
  Left = 492
  Top = 296
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Configura'#231#227'o do Servidor Proxy'
  ClientHeight = 218
  ClientWidth = 320
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lUser: TLabel
    Left = 46
    Top = 84
    Width = 39
    Height = 13
    Caption = 'Usu'#225'rio:'
    Color = clBtnFace
    ParentColor = False
    Transparent = False
  end
  object lSenha: TLabel
    Left = 46
    Top = 127
    Width = 34
    Height = 13
    Caption = 'Senha:'
    Color = clBtnFace
    ParentColor = False
  end
  object lUser1: TLabel
    Left = 26
    Top = 12
    Width = 42
    Height = 13
    Caption = 'Servidor:'
    Color = clBtnFace
    ParentColor = False
    Transparent = False
  end
  object lSenha1: TLabel
    Left = 246
    Top = 12
    Width = 28
    Height = 13
    Caption = 'Porta:'
    Color = clBtnFace
    ParentColor = False
    Transparent = False
  end
  object Panel2: TPanel
    Left = 0
    Top = 184
    Width = 320
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object bOk: TBitBtn
      Left = 111
      Top = 3
      Width = 100
      Height = 28
      Hint = 'Iniciar Pesquisa'
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF001808086531000400FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00180839A66B6BEBB539
        925A000800FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF00180031A26339E39C18DB8C52E7AD398E5A000C00FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF001C00219E5229D78C18CF8418D38418
        D78442DF9C318A4A000C00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF001C00
        10924218C77318C36B18C77318C77B18CB7B18CF7B29D78C218642001000FF00
        FFFF00FFFF00FFFF00FF002400108E3918BA6318B66331C37342CB8442D38C4A
        CF8C39CB8429C77B21CB7B108A39001800FF00FFFF00FFFF00FF08712921B65A
        52BE8473CF9C7BD7A542BE7B107D4252CF947BDBAD73D7A56BD39C42CB84108A
        31002000FF00FFFF00FF0030104AB26B9CDBB594DBB542BA73003010FF00FF08
        45215ACF8C9CDFBD94DBB594DBB55ACB8C108A31002800FF00FFFF00FF002008
        52AE7342AA6B001C08FF00FFFF00FFFF00FF0030105ABE84B5E7CEB5E3C6B5E3
        C673CF9C108629002C00FF00FFFF00FF001800001400FF00FFFF00FFFF00FFFF
        00FFFF00FF00200852AE73D6F3DECEEBDEDEEFE794DBAD085D18FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF001400529E63EFFF
        F7DEF7E742965A001000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF000000428E5239864A000000FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000C
        00000C00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    end
    object bCancelar: TBitBtn
      Left = 217
      Top = 3
      Width = 100
      Height = 28
      Hint = 'ESC = Cancelar'
      Cancel = True
      Caption = 'Cancelar'
      ModalResult = 2
      TabOrder = 1
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        101073000029FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0004
        3110106BFF00FFFF00FFFF00FF00008C3134F70808CE000031FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF000039080CCE3130EF00007BFF00FF0000630808E7
        4A49F74A4DF70000C6000039FF00FFFF00FFFF00FFFF00FF00004A0004CE5A59
        EF5A59F70808DE00004A0004842120FF3134FF5A59FF4A49EF0004C6000042FF
        00FFFF00FF0000520808CE5A59EF7371FF5255FF3134FF00046B000473181CFF
        2928FF3938FF5255FF4245EF0004C600004A00005A0808CE5255EF6B69FF5251
        FF4241FF3130FF080C52FF00FF08087B181CFF2928FF3134FF4A49FF3134EF00
        00BD0004C64245EF5A59FF4245FF393CFF292CFF080C63FF00FFFF00FFFF00FF
        08086B1818FF292CFF393CFF4A4DFF3130EF3134EF4A49FF3938FF3130FF2124
        F708084AFF00FFFF00FFFF00FFFF00FFFF00FF000452393CEF6361FF6361FF63
        61FF6361FF6361FF5A59FF2928DE000439FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF00048C393CF76361FF6361FF6365FF6365FF3134EF000463FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00005A0000A53130F76B69FF6B
        69FF6B69FF6B69FF2120E700009C000042FF00FFFF00FFFF00FFFF00FFFF00FF
        0000520000A53134F77B79FF7B79FF7B79FF7B79FF7B79FF7375FF2124E70000
        94000039FF00FFFF00FFFF00FF00005200009C4241F78C8AFF8C8AFF8C8AFF31
        30C64A49DE8C8EFF8C8AFF8486FF2928E700008C000039FF00FF00001800009C
        4A49F79C9AFF9C9AFF9C9AFF3134BDFF00FF0000215255E79C9EFF9C9AFF9496
        FF292CE700007BFF00FF0000295255FFADAEFFADAAFFADAAFF393CBDFF00FFFF
        00FFFF00FF0000295A5DE7ADAEFFADAAFFADAAFF3130DEFF00FFFF00FF4245BD
        BDBAFFBDBAFF393CBDFF00FFFF00FFFF00FFFF00FFFF00FF0000296B69E7CECB
        FFA5A6FF21248CFF00FFFF00FFFF00FF393CBD4241C6FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF0000295A59E7181C7BFF00FFFF00FF}
    end
  end
  object edUser: TEdit
    Left = 46
    Top = 100
    Width = 172
    Height = 21
    Enabled = False
    TabOrder = 3
  end
  object edSenha: TEdit
    Left = 46
    Top = 143
    Width = 172
    Height = 21
    Enabled = False
    PasswordChar = '*'
    TabOrder = 4
  end
  object edServidor: TEdit
    Left = 26
    Top = 28
    Width = 214
    Height = 21
    TabOrder = 0
  end
  object edPorta: TEdit
    Left = 246
    Top = 28
    Width = 48
    Height = 21
    TabOrder = 1
  end
  object cbAutenticacao: TCheckBox
    Left = 26
    Top = 59
    Width = 183
    Height = 19
    Caption = 'O Servidor requer autentica'#231#227'o'
    TabOrder = 2
  end
end
