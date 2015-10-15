{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emiss�o de Nota Fiscal}
{ eletr�nica - NFe - http://www.nfe.fazenda.gov.br                             }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       Andr� Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{$I ACBr.inc}
unit ACBrNFeDANFeRLClass;

interface

uses SysUtils, Classes,
  {$IFDEF CLX}
  QForms, QDialogs,
  {$ELSE}
  Forms, Dialogs,
  {$ENDIF}
  RLConsts, pcnNFe, pcnConversao, ACBrNFeDANFEClass;

type
  TNomeFonte = (nfTimesNewRoman, nfCourierNew, nfArial);
  TPosCanhoto = (pcCabecalho, pcRodape);
  TDetVeiculo = (dv_tpOp, dv_chassi, dv_cCor, dv_xCor, dv_pot, dv_cilin,
                 dv_pesoL, dv_pesoB, dv_nSerie, dv_tpComb, dv_nMotor, dv_CMT,
                 dv_dist, dv_anoMod, dv_anoFab, dv_tpPint, dv_tpVeic,
                 dv_espVeic, dv_VIN, dv_condVeic, dv_cMod, dv_cCorDENATRAN,
                 dv_lota, dv_tpRest);
  TDetMedicamento = (dm_nLote, dm_qLote, dm_dFab, dm_dVal, dm_vPMC);
  TDetArmamento = (da_tpArma, da_nSerie, da_nCano, da_descr);
  TDetCombustivel = (dc_cProdANP, dc_CODIF, dc_qTemp, dc_UFCons, dc_CIDE,
                     dc_qBCProd, dc_vAliqProd, dc_vCIDE);
  TDetVeiculos = set of TDetVeiculo;
  TDetMedicamentos = set of TDetMedicamento;
  TDetArmamentos = set of TDetArmamento;
  TDetCombustiveis = set of TDetCombustivel;


  TFonte = class(TComponent)
  protected
    FNome: TNomeFonte;
    FNegrito: Boolean;
    FTamanhoFonte_RazaoSocial: Integer;

  public
    constructor Create(AOwner: TComponent); override ;
    destructor Destroy; override;

  published
    property Nome: TNomeFonte read FNome write FNome default nfTimesNewRoman;
    property Negrito: Boolean read FNegrito write FNegrito default False;
    property TamanhoFonte_RazaoSocial: Integer read FTamanhoFonte_RazaoSocial
                                              write FTamanhoFonte_RazaoSocial
                                              default 8;
  end;

  TACBrNFeDANFeRL = class( TACBrNFeDANFEClass )
  private
    FMarcadagua: string;
    FLarguraCodProd: Integer;
    FPosCanhoto: TPosCanhoto;
    fExibeCampoFatura: Boolean;
    FFonte: TFonte;
    FExibirEAN: Boolean;
    FDetVeiculos: TDetVeiculos;
    FDetMedicamentos: TDetMedicamentos;
    FDetArmamentos: TDetArmamentos;
    FDetCombustiveis: TDetCombustiveis;
    fQuebraLinhaEmVeiculos : Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFE(NFE : TNFe = nil); override ;
    procedure ImprimirDANFEPDF(NFE : TNFe = nil); override ;
    procedure ImprimirEVENTO(NFE : TNFe = nil); override ;
    procedure ImprimirEVENTOPDF(NFE : TNFe = nil); override ;
    procedure ImprimirINUTILIZACAO(NFe: TNFe = nil); override;
    procedure ImprimirINUTILIZACAOPDF(NFe: TNFe = nil); override;
    procedure SetExibirEAN(Value: Boolean); virtual;
    procedure SetTipoDANFE(Value: TpcnTipoImpressao); virtual;
  published
    property MarcadAgua : String read FMarcadagua write FMarcadagua ;
    property LarguraCodProd: Integer read FLarguraCodProd write FLarguraCodProd;
    property PosCanhoto: TPosCanhoto read FPosCanhoto write FPosCanhoto
                                                          default pcCabecalho;
    property Fonte: TFonte read FFonte;
    property ExibirEAN: Boolean read FExibirEAN write SetExibirEAN;
    property DetVeiculos: TDetVeiculos read FDetVeiculos write FDetVeiculos default
                          [dv_chassi, dv_xCor, dv_nSerie, dv_tpComb, dv_nMotor, dv_anoMod, dv_anoFab];
    property DetMedicamentos: TDetMedicamentos read FDetMedicamentos write FDetMedicamentos default
                              [dm_nLote, dm_qLote, dm_dFab, dm_dVal, dm_vPMC];
    property DetArmamentos: TDetArmamentos read FDetArmamentos write FDetArmamentos default
                            [da_tpArma, da_nSerie, da_nCano, da_descr];
    property DetCombustiveis: TDetCombustiveis read FDetCombustiveis write FDetCombustiveis default
                            [dc_cProdANP, dc_CODIF, dc_qTemp, dc_UFCons, dc_CIDE, dc_qBCProd, dc_vAliqProd, dc_vCIDE];
    property QuebraLinhaEmVeiculos : Boolean  read fQuebraLinhaEmVeiculos write fQuebraLinhaEmVeiculos;
    property ExibeCampoFatura: Boolean        read fExibeCampoFatura      write fExibeCampoFatura;
  end;

implementation

uses ACBrNFe, ACBrUtil,
     ACBrNFeDANFeRL, ACBrNFeDANFeEventoRL,
     ACBrNFeDANFeRLRetrato, ACBrNFeDANFeRLPaisagem,
     ACBrNFeDANFeEventoRLRetrato, ACBrNFeDANFeRLSimplificado,
     ACBrNFeDAInutRL, ACBrNFeDAInutRLRetrato;

var
  frlDANFeRL: TfrlDANFeRL;
  frlDANFeEventoRL: TfrlDANFeEventoRL;
  frmNFeDAInutRL : TfrmNFeDAInutRL;

constructor TFonte.Create(AOwner: TComponent);
begin
  inherited create( AOwner );
  FNome := nfTimesNewRoman;
  FNegrito := False;
  FTamanhoFonte_RazaoSocial := 8;
end;

destructor TFonte.Destroy;
begin
  inherited Destroy;
end;

constructor TACBrNFeDANFeRL.Create(AOwner: TComponent);
begin
  inherited create( AOwner );
  FFonte := TFonte.Create(self);
  FFonte.Name := 'Fonte';
  FLarguraCodProd := 54;
  FMargemSuperior := 0.70;
  FMargemInferior := 0.70;
  FMargemEsquerda := 0.70;
  FMargemDireita := 0.70;
  fCasasDecimais.Tag := 0;
  FCasasDecimais._qCom := 4;
  FCasasDecimais._vUnCom := 4;
  FProdutosPorPagina := 0;
  FExibirEAN := False;
  FTipoDANFE := tiRetrato;
  FPosCanhoto := pcCabecalho;
  FDetVeiculos := [dv_chassi, dv_xCor, dv_nSerie, dv_tpComb, dv_nMotor, dv_anoMod, dv_anoFab];
  FDetMedicamentos := [dm_nLote, dm_qLote, dm_dFab, dm_dVal, dm_vPMC];
  FDetArmamentos := [da_tpArma, da_nSerie, da_nCano, da_descr];
  FDetCombustiveis := [dc_cProdANP, dc_CODIF, dc_qTemp, dc_UFCons, dc_CIDE, dc_qBCProd, dc_vAliqProd, dc_vCIDE];
  fQuebraLinhaEmVeiculos  := True;
  fExibeCampoFatura       := False;
end;

destructor TACBrNFeDANFeRL.Destroy;
begin
  FFonte.Destroy;
  inherited Destroy ;
end;

procedure TACBrNFeDANFeRL.ImprimirDANFE(NFE: TNFe = nil);
var
 i : Integer;
begin
try
  case TipoDANFE of
    tiRetrato      : frlDANFeRL := TfrlDANFeRLRetrato.Create(Self);
    tiPaisagem     : frlDANFeRL := TfrlDANFeRLPaisagem.Create(Self);
    tiSimplificado : frlDANFeRL := TfrlDANFeRLSimplificado.Create(Self);
  else
    frlDANFeRL := TfrlDANFeRLRetrato.Create(Self);
  end;

  if NFE = nil then
    begin
      for i:= 0 to TACBrNFe(ACBrNFe).NotasFiscais.Count - 1 do
        begin
          frlDANFeRL.Imprimir( Self, TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe,
          FLogo, FMarcaDagua, FLarguraCodProd, FEmail, FExibeResumoCanhoto, FFax,
          FNumCopias, FSistema, FSite, FUsuario, FPosCanhoto, FFormularioContinuo,
          FExpandirLogoMarca, FMostrarPreview, FMostrarStatus, FFonte.FNome,
          FFonte.FNegrito, FMargemSuperior, FMargemInferior, FMargemEsquerda,
          FMargemDireita, FCasasDecimais._qCom,
          FCasasDecimais._vUnCom, FProdutosPorPagina, FImpressora,
          FFonte.FTamanhoFonte_RazaoSocial, FExibirEAN, FProtocoloNFe,
          FExibeResumoCanhoto_Texto, FNFeCancelada,
          FImprimirDetalhamentoEspecifico, FImprimeDescPorc,
          FDetVeiculos, FDetMedicamentos, FDetArmamentos, FDetCombustiveis,
          fQuebraLinhaEmVeiculos,
          Integer ( fCasasDecimais.Formato ),
          fCasasDecimais._Mask_qCom,
          fCasasDecimais._Mask_vUnCom,
          fExibeCampoFatura );
        end;
    end
  else
    begin
      frlDANFeRL.Imprimir( Self, NFE,
      FLogo, FMarcaDagua, FLarguraCodProd, FEmail, FExibeResumoCanhoto, FFax,
      FNumCopias, FSistema, FSite, FUsuario, FPosCanhoto, FFormularioContinuo,
      FExpandirLogoMarca, FMostrarPreview, FMostrarStatus, FFonte.FNome,
      FFonte.FNegrito, FMargemSuperior, FMargemInferior, FMargemEsquerda,
      FMargemDireita, FCasasDecimais._qCom,
      FCasasDecimais._vUnCom, FProdutosPorPagina, FImpressora,
      FFonte.FTamanhoFonte_RazaoSocial, FExibirEAN, FProtocoloNFe,
      FExibeResumoCanhoto_Texto, FNFeCancelada,
      FImprimirDetalhamentoEspecifico, FImprimeDescPorc,
      FDetVeiculos, FDetMedicamentos, FDetArmamentos, FDetCombustiveis,
      fQuebraLinhaEmVeiculos,
      Integer ( fCasasDecimais.Formato ),
      fCasasDecimais._Mask_qCom,
      fCasasDecimais._Mask_vUnCom,
      fExibeCampoFatura );
    end;

  finally
    FreeAndNil(frlDANFeRL);
  end;
end;

procedure TACBrNFeDANFeRL.ImprimirDANFEPDF(NFE : TNFe = nil);
var sFile: String;
var
  i : Integer;
begin
  try
  case TipoDANFE of
    tiRetrato      : frlDANFeRL := TfrlDANFeRLRetrato.Create(Self);
    tiPaisagem     : frlDANFeRL := TfrlDANFeRLPaisagem.Create(Self);
    tiSimplificado : frlDANFeRL := TfrlDANFeRLSimplificado.Create(Self);
  else
    frlDANFeRL := TfrlDANFeRLRetrato.Create(Self);
  end;

  if NFE = nil then
    begin
      for i:= 0 to TACBrNFe(ACBrNFe).NotasFiscais.Count-1 do
        begin
//          sFile := TACBrNFe(ACBrNFe).DANFE.PathPDF +
//                   Copy(TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe.infNFe.ID,
//                   4, 44) + '-nfe.pdf';
          sFile := TACBrNFe(ACBrNFe).DANFE.PathPDF +
                   StringReplace(TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe.infNFe.ID,'NFe', '', [rfIgnoreCase])
                   + '-nfe.pdf';

          frlDANFeRL.SavePDF(TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe,
          FLogo, FMarcaDagua, FLarguraCodProd, FEmail, FExibeResumoCanhoto, FFax,
          FNumCopias, FSistema, FSite, FUsuario, sFile, FPosCanhoto, FFormularioContinuo,
          FExpandirLogoMarca, FMostrarStatus, FFonte.FNome, FFonte.FNegrito, FMargemSuperior,
          FMargemInferior, FMargemEsquerda, FMargemDireita, FCasasDecimais._qCom,
          FCasasDecimais._vUnCom, FProdutosPorPagina,
          FFonte.FTamanhoFonte_RazaoSocial, FExibirEAN, FProtocoloNFe,
          FExibeResumoCanhoto_Texto, FNFeCancelada,
          FImprimirDetalhamentoEspecifico, FImprimeDescPorc,
          FDetVeiculos, FDetMedicamentos, FDetArmamentos, FDetCombustiveis,
          fQuebraLinhaEmVeiculos,
          Integer ( fCasasDecimais.Formato ),
          fCasasDecimais._Mask_qCom,
          fCasasDecimais._Mask_vUnCom,
          fExibeCampoFatura );
        end;
    end
  else
    begin
//      sFile := Self.PathPDF + Copy(NFe.infNFe.ID, 4, 44) + '-nfe.pdf';
      sFile := Self.PathPDF +
               StringReplace(NFe.infNFe.ID,'NFe', '', [rfIgnoreCase]) +
               '-nfe.pdf';

      frlDANFeRL.SavePDF(NFe,
      FLogo, FMarcaDagua, FLarguraCodProd, FEmail, FExibeResumoCanhoto, FFax,
      FNumCopias, FSistema, FSite, FUsuario, sFile, FPosCanhoto, FFormularioContinuo,
      FExpandirLogoMarca, FMostrarStatus, FFonte.FNome, FFonte.FNegrito, FMargemSuperior,
      FMargemInferior, FMargemEsquerda, FMargemDireita, FCasasDecimais._qCom,
      FCasasDecimais._vUnCom, FProdutosPorPagina,
      FFonte.FTamanhoFonte_RazaoSocial, FExibirEAN, FProtocoloNFe,
      FExibeResumoCanhoto_Texto, FNFeCancelada,
      FImprimirDetalhamentoEspecifico, FImprimeDescPorc,
      FDetVeiculos, FDetMedicamentos, FDetArmamentos, FDetCombustiveis,
      fQuebraLinhaEmVeiculos,
      Integer ( fCasasDecimais.Formato ),
      fCasasDecimais._Mask_qCom,
      fCasasDecimais._Mask_vUnCom,
      fExibeCampoFatura );
    end;
 finally
   FreeAndNil(frlDANFeRL);
 end;
end;

procedure TACBrNFeDANFeRL.SetExibirEAN(Value: Boolean);
begin
  if FTipoDANFE = tiRetrato then
    FExibirEAN := False
  else
    FExibirEAN := Value;
end;

procedure TACBrNFeDANFeRL.SetTipoDANFE(Value: TpcnTipoImpressao);
begin
  if Value = tiRetrato then
    begin
      FExibirEAN := False;
    end;

  FTipoDANFE := Value;
end;

procedure TACBrNFeDANFeRL.ImprimirEVENTO(NFE: TNFe);
var Impresso: Boolean;
I, J : Integer;
begin
try
  case TipoDANFE of
    tiRetrato,
    tiPaisagem: frlDANFeEventoRL := TfrlDANFeEventoRLRetrato.Create(Self);
  else
    frlDANFeEventoRL := TfrlDANFeEventoRLRetrato.Create(Self);
  end;

  if TACBrNFe(ACBrNFe).NotasFiscais.Count > 0 then
    begin
      for i := 0 to (TACBrNFe(ACBrNFe).EventoNFe.Evento.Count - 1) do
        begin
          Impresso := False;
          for j := 0 to (TACBrNFe(ACBrNFe).NotasFiscais.Count - 1) do
            begin
//              if Copy(TACBrNFe(ACBrNFe).NotasFiscais.Items[j].NFe.infNFe.ID, 4, 44) = TACBrNFe(ACBrNFe).EventoNFe.Evento.Items[i].InfEvento.chNFe then
              if StringReplace(TACBrNFe(ACBrNFe).NotasFiscais.Items[j].NFe.infNFe.ID,'NFe', '', [rfIgnoreCase]) = TACBrNFe(ACBrNFe).EventoNFe.Evento.Items[i].InfEvento.chNFe then

                begin
                  frlDANFeEventoRL.Imprimir(Self, TACBrNFe(ACBrNFe).EventoNFe.Evento.Items[i],
                  FLogo, FMarcadagua, FNumCopias, FSistema, FUsuario, FMostrarPreview,
                  FFonte.FNome, FFonte.FNegrito, FMargemSuperior, FMargemInferior,
                  FMargemEsquerda, FMargemDireita, FImpressora,
                  TACBrNFe(ACBrNFe).NotasFiscais.Items[j].NFe);
                  Impresso := True;
                  Break;
                end; // if Copy(TACBrNFe(ACBrNFe).NotasFiscais.Items[j].NFe.infNFe.ID, 4, 44)
            end; // for j := 0 to (TACBrNFe(ACBrNFe).NotasFiscais.Count - 1)

          if Impresso = False then
            begin
              frlDANFeEventoRL.Imprimir(Self, TACBrNFe(ACBrNFe).EventoNFe.Evento.Items[i],
              FLogo, FMarcadagua, FNumCopias, FSistema, FUsuario, FMostrarPreview,
              FFonte.FNome, FFonte.FNegrito, FMargemSuperior, FMargemInferior,
              FMargemEsquerda, FMargemDireita, FImpressora);
            end;
        end; // for i := 0 to (TACBrNFe(ACBrNFe).EventoNFe.Evento.Count - 1)
    end // if TACBrNFe(ACBrNFe).NotasFiscais.Count > 0
  else
    begin
      for i := 0 to (TACBrNFe(ACBrNFe).EventoNFe.Evento.Count - 1) do
        begin
          frlDANFeEventoRL.Imprimir(Self, TACBrNFe(ACBrNFe).EventoNFe.Evento.Items[i],
          FLogo, FMarcadagua, FNumCopias, FSistema, FUsuario, FMostrarPreview,
          FFonte.FNome, FFonte.FNegrito, FMargemSuperior, FMargemInferior,
          FMargemEsquerda, FMargemDireita, FImpressora);
        end;
    end;

 finally
  FreeAndNil(frlDANFeEventoRL);
 end;
end;

procedure TACBrNFeDANFeRL.ImprimirEVENTOPDF(NFE: TNFe);
var sFile: String;
Impresso: Boolean;
I, J : Integer;
begin
try
  case TipoDANFE of
    tiRetrato,
    tiPaisagem: frlDANFeEventoRL := TfrlDANFeEventoRLRetrato.Create(Self);
  else
    frlDANFeEventoRL := TfrlDANFeEventoRLRetrato.Create(Self);
  end;

  if TACBrNFe(ACBrNFe).NotasFiscais.Count > 0 then
    begin
      for i := 0 to (TACBrNFe(ACBrNFe).EventoNFe.Evento.Count - 1) do
        begin
          sFile := TACBrNFe(ACBrNFe).DANFE.PathPDF +
                   StringReplace(TACBrNFe(ACBrNFe).EventoNFe.Evento.Items[i].InfEvento.id, 'ID', '', [rfIgnoreCase]) +
                   '-procEventoNFe.pdf';

//          Copy(TACBrNFe(ACBrNFe).EventoNFe.Evento.Items[i].InfEvento.id, 3, 52) + 'evento.pdf';
          Impresso := False;

          for j := 0 to (TACBrNFe(ACBrNFe).NotasFiscais.Count - 1) do
            begin
//              if Copy(TACBrNFe(ACBrNFe).NotasFiscais.Items[j].NFe.infNFe.ID, 4, 44) = TACBrNFe(ACBrNFe).EventoNFe.Evento.Items[i].InfEvento.chNFe then
              if StringReplace(TACBrNFe(ACBrNFe).NotasFiscais.Items[j].NFe.infNFe.ID,'NFe', '', [rfIgnoreCase]) = TACBrNFe(ACBrNFe).EventoNFe.Evento.Items[i].InfEvento.chNFe then
                begin
                  frlDANFeEventoRL.SavePDF(Self, TACBrNFe(ACBrNFe).EventoNFe.Evento.Items[i],
                  FLogo, FMarcadagua, sFile, FSistema, FUsuario, FFonte.FNome, FFonte.FNegrito,
                  FMargemSuperior, FMargemInferior, FMargemEsquerda, FMargemDireita,
                  TACBrNFe(ACBrNFe).NotasFiscais.Items[j].NFe);
                  Impresso := True;
                  Break;
                end; // if Copy(TACBrNFe(ACBrNFe).NotasFiscais.Items[j].NFe.infNFe.ID, 4, 44)
            end; // for j := 0 to (TACBrNFe(ACBrNFe).NotasFiscais.Count - 1)

          if Impresso = False then
            begin
              frlDANFeEventoRL.SavePDF(Self, TACBrNFe(ACBrNFe).EventoNFe.Evento.Items[i],
              FLogo, FMarcadagua, sFile, FSistema, FUsuario, FFonte.FNome, FFonte.FNegrito,
              FMargemSuperior, FMargemInferior, FMargemEsquerda, FMargemDireita);
            end;
        end; // for i := 0 to (TACBrNFe(ACBrNFe).EventoNFe.Evento.Count - 1)
    end // if TACBrNFe(ACBrNFe).NotasFiscais.Count > 0
  else
    begin
      for i := 0 to (TACBrNFe(ACBrNFe).EventoNFe.Evento.Count - 1) do
        begin
          sFile := TACBrNFe(ACBrNFe).DANFE.PathPDF +
                   StringReplace(TACBrNFe(ACBrNFe).EventoNFe.Evento.Items[i].InfEvento.id, 'ID', '', [rfIgnoreCase]) +
                   '-procEventoNFe.pdf';
//          Copy(TACBrNFe(ACBrNFe).EventoNFe.Evento.Items[i].InfEvento.id, 3, 52) + 'evento.pdf';

          frlDANFeEventoRL.SavePDF(Self, TACBrNFe(ACBrNFe).EventoNFe.Evento.Items[i],
          FLogo, FMarcadagua, sFile, FSistema, FUsuario, FFonte.FNome, FFonte.FNegrito,
          FMargemSuperior, FMargemInferior, FMargemEsquerda, FMargemDireita);
        end;
    end;
 finally
  FreeAndNil(frlDANFeEventoRL);
 end; 
end;

procedure TACBrNFeDANFErl.ImprimirINUTILIZACAO(NFe: TNFe);
begin
  frmNFeDAInutRL := TfrmNFeDAInutRLRetrato.Create(Self);

  frmNFeDAInutRL.Imprimir(TACBrNFe(ACBrNFe),
                          FLogo, FNumCopias, FSistema, FUsuario,
                          FMostrarPreview, FMargemSuperior,
                          FMargemInferior, FMargemEsquerda,
                          FMargemDireita, FImpressora);

  FreeAndNil(frmNFeDAInutRL);
end;

procedure TACBrNFeDANFErl.ImprimirINUTILIZACAOPDF(NFe: TNFe);
var
 NomeArq: String;
begin
  frmNFeDAInutRL := TfrmNFeDAInutRLRetrato.Create(Self);

  NomeArq := StringReplace(TACBrNFe(ACBrNFe).InutNFe.ID, 'ID', '', [rfIgnoreCase]);
  if NomeArq = '' then
    NomeArq := StringReplace(TACBrNFe(ACBrNFe).InutNFe.ID, 'ID', '', [rfIgnoreCase]);
  NomeArq := PathWithDelim(Self.PathPDF) + NomeArq + '-procInutNFe.pdf';

  frmNFeDAInutRL.SavePDF(TACBrNFe(ACBrNFe),
                         FLogo, NomeArq, FSistema, FUsuario,
                         FMargemSuperior, FMargemInferior,
                         FMargemEsquerda, FMargemDireita);

  FreeAndNil(frmNFeDAInutRL);
end;

end.
