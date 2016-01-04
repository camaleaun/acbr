{******************************************************************************}
{ Projeto: Componente ACBrMDFe                                                 }
{  Biblioteca multiplataforma de componentes Delphi                            }
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

{*******************************************************************************
|* Historico
|*
|* 01/08/2012: Italo Jurisato Junior
|*  - Doa��o do componente para o Projeto ACBr
*******************************************************************************}

{$I ACBr.inc}

unit ACBrMDFeWebServices;

interface

uses
  Classes, SysUtils,
  ACBrDFe, ACBrDFeWebService,
  pmdfeMDFe,
  pmdfeRetConsReciMDFe, pcnAuxiliar, pcnConversao, pmdfeConversaoMDFe,
  pmdfeProcMDFe, pmdfeEnvEventoMDFe, pmdfeRetEnvEventoMDFe,
  pmdfeRetConsSitMDFe, pmdfeRetConsMDFeNaoEnc, pmdfeRetEnvMDFe,
  pmdfeDistDFeInt, pmdfeRetDistDFeInt,
  ACBrMDFeManifestos, ACBrMDFeConfiguracoes;

const
  CURL_WSDL = 'http://www.portalfiscal.inf.br/mdfe/wsdl/';
  INTERNET_OPTION_CLIENT_CERT_CONTEXT = 84;

type

  { TMDFeWebService }

  TMDFeWebService = class(TDFeWebService)
  private
  protected
    FPStatus: TStatusACBrMDFe;
    FPLayout: TLayOutMDFe;
    FPConfiguracoesMDFe: TConfiguracoesMDFe;

    function ExtrairModeloChaveAcesso(AChaveMDFe: String): String;
    function ExtrairUFChaveAcesso(AChaveMDFe: String): Integer;
  protected
    procedure InicializarServico; override;
    procedure DefinirURL; override;
    function GerarVersaoDadosSoap: String; override;
    procedure FinalizarServico; override;

  public
    constructor Create(AOwner: TACBrDFe); override;
    procedure Clear; override;

    property Status: TStatusACBrMDFe read FPStatus;
    property Layout: TLayOutMDFe read FPLayout;
  end;

  { TMDFeStatusServico }

  TMDFeStatusServico = class(TMDFeWebService)
  private
    Fversao: String;
    FtpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FcUF: Integer;
    FdhRecbto: TDateTime;
    FTMed: Integer;
    FdhRetorno: TDateTime;
    FxObs: String;
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
    function GerarMsgErro(E: Exception): String; override;
  public
    procedure Clear; override;

    property versao: String read Fversao;
    property tpAmb: TpcnTipoAmbiente read FtpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property xMotivo: String read FxMotivo;
    property cUF: Integer read FcUF;
    property dhRecbto: TDateTime read FdhRecbto;
    property TMed: Integer read FTMed;
    property dhRetorno: TDateTime read FdhRetorno;
    property xObs: String read FxObs;
  end;

  { TMDFeRecepcao }

  TMDFeRecepcao = class(TMDFeWebService)
  private
    FLote: String;
    FRecibo: String;
    FManifestos: TManifestos;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
    FxMotivo: String;
    FdhRecbto: TDateTime;
    FTMed: Integer;

    FMDFeRetorno: TretEnvMDFe;

    function GetLote: String;
    function GetRecibo: String;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner: TACBrDFe; AManifestos: TManifestos);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property Recibo: String read GetRecibo;
    property versao: String read Fversao;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property xMotivo: String read FxMotivo;
    property dhRecbto: TDateTime read FdhRecbto;
    property TMed: Integer read FTMed;
    property Lote: String read GetLote write FLote;
  end;

  { TMDFeRetRecepcao }

  TMDFeRetRecepcao = class(TMDFeWebService)
  private
    FRecibo: String;
    FProtocolo: String;
    FChaveMDFe: String;
    FManifestos: TManifestos;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
    FxMotivo: String;
    FcMsg: Integer;
    FxMsg: String;

    FMDFeRetorno: TRetConsReciMDFe;

    function GetRecibo: String;
    function TratarRespostaFinal: Boolean;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;
    procedure FinalizarServico; override;

    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner: TACBrDFe; AManifestos: TManifestos);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    function Executar: Boolean; override;

    property versao: String read Fversao;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property xMotivo: String read FxMotivo;
    property cMsg: Integer read FcMsg;
    property xMsg: String read FxMsg;
    property Recibo: String read GetRecibo write FRecibo;
    property Protocolo: String read FProtocolo write FProtocolo;
    property ChaveMDFe: String read FChaveMDFe write FChaveMDFe;

    property MDFeRetorno: TRetConsReciMDFe read FMDFeRetorno;
  end;

  { TMDFeRecibo }

  TMDFeRecibo = class(TMDFeWebService)
  private
    FManifestos: TManifestos;
    FRecibo: String;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FcUF: Integer;
    FxMsg: String;
    FcMsg: Integer;

    FMDFeRetorno: TRetConsReciMDFe;
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirURL; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
  public
    constructor Create(AOwner: TACBrDFe; AManifestos: TManifestos);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property versao: String read Fversao;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property xMotivo: String read FxMotivo;
    property cUF: Integer read FcUF;
    property xMsg: String read FxMsg;
    property cMsg: Integer read FcMsg;
    property Recibo: String read FRecibo write FRecibo;

    property MDFeRetorno: TRetConsReciMDFe read FMDFeRetorno;
  end;

  { TMDFeConsulta }

  TMDFeConsulta = class(TMDFeWebService)
  private
    FOwner: TACBrDFe;
    FManifestos: TManifestos;
    FMDFeChave: String;
    FProtocolo: String;
    FDhRecbto: TDateTime;
    FXMotivo: String;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
    FRetMDFeDFe: String;

    FprotMDFe: TProcMDFe;
    FprocEventoMDFe: TRetEventoMDFeCollection;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function GerarUFSoap: String; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner: TACBrDFe; AManifestos: TManifestos);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property MDFeChave: String read FMDFeChave write FMDFeChave;
    property Protocolo: String read FProtocolo;
    property DhRecbto: TDateTime read FDhRecbto;
    property XMotivo: String read FXMotivo;
    property versao: String read Fversao;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property RetMDFeDFe: String read FRetMDFeDFe;

    property protMDFe: TProcMDFe read FprotMDFe;
    property procEventoMDFe: TRetEventoMDFeCollection read FprocEventoMDFe;
  end;

  { TMDFeEnvEvento }

  TMDFeEnvEvento = class(TMDFeWebService)
  private
    FidLote: Integer;
    FEvento: TEventoMDFe;
    FcStat: Integer;
    FxMotivo: String;
    FTpAmb: TpcnTipoAmbiente;
    FCNPJ: String;

    FEventoRetorno: TRetEventoMDFe;

    function GerarPathEvento(const ACNPJ: String = ''): String;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    procedure SalvarEnvio; override;
    function TratarResposta: Boolean; override;
    procedure SalvarResposta; override;

    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner: TACBrDFe; AEvento: TEventoMDFe);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property idLote: Integer read FidLote write FidLote;
    property cStat: Integer read FcStat;
    property xMotivo: String read FxMotivo;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;

    property EventoRetorno: TRetEventoMDFe read FEventoRetorno;
  end;

  { TMDFeConsultaMDFeNaoEnc }

  TMDFeConsultaMDFeNaoEnc = Class(TMDFeWebService)
  private
    FOwner: TACBrDFe;
    FCNPJ: String;
    Fversao: String;
    FtpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FcUF: Integer;
    FInfMDFe: TRetInfMDFeCollection;
    FRetConsMDFeNaoEnc: TRetConsMDFeNaoEnc;
    FMsg: String;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
    function GerarMsgErro(E: Exception): String; override;
  public
    constructor Create(AOwner: TACBrDFe); override;
    destructor Destroy; override;
    procedure Clear; override;

    property CNPJ: String                   read FCNPJ write FCNPJ;
    property versao: String                 read Fversao;
    property tpAmb: TpcnTipoAmbiente        read FtpAmb;
    property verAplic: String               read FverAplic;
    property cStat: Integer                 read FcStat;
    property xMotivo: String                read FxMotivo;
    property cUF: Integer                   read FcUF;
    property InfMDFe: TRetInfMDFeCollection read FInfMDFe;
    property Msg: String                    read FMsg;
  end;

  { TDistribuicaoDFe }

  TDistribuicaoDFe = class(TMDFeWebService)
  private
//    FcUFAutor: Integer;
    FCNPJCPF: String;
    FultNSU: String;
    FNSU: String;

    FretDistDFeInt: TretDistDFeInt;

    function GerarPathDistribuicao(AItem :TdocZipCollectionItem): String;
  protected
//    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
    function GerarMsgErro(E: Exception): String; override;
  public
    constructor Create(AOwner: TACBrDFe); override;
    destructor Destroy; override;
    procedure Clear; override;

//    property cUFAutor: Integer read FcUFAutor write FcUFAutor;
    property CNPJCPF: String read FCNPJCPF write FCNPJCPF;
    property ultNSU: String read FultNSU write FultNSU;
    property NSU: String read FNSU write FNSU;

    property retDistDFeInt: TretDistDFeInt read FretDistDFeInt;
  end;

 { TMDFeEnvioWebService }

  TMDFeEnvioWebService = class(TMDFeWebService)
  private
    FXMLEnvio: String;
    FPURLEnvio: String;
    FVersao: String;
    FSoapActionEnvio: String;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgErro(E: Exception): String; override;
    function GerarVersaoDadosSoap: String; override;
  public
    constructor Create(AOwner: TACBrDFe); override;
    destructor Destroy; override;
    procedure Clear; override;

    function Executar: Boolean; override;

    property Versao: String read FVersao;
    property XMLEnvio: String read FXMLEnvio write FXMLEnvio;
    property URLEnvio: String read FPURLEnvio write FPURLEnvio;
    property SoapActionEnvio: String read FSoapActionEnvio write FSoapActionEnvio;
  end;

  { TWebServices }

  TWebServices = class
  private
    FACBrMDFe: TACBrDFe;
    FStatusServico: TMDFeStatusServico;
    FEnviar: TMDFeRecepcao;
    FRetorno: TMDFeRetRecepcao;
    FRecibo: TMDFeRecibo;
    FConsulta: TMDFeConsulta;
    FEnvEvento: TMDFeEnvEvento;
    FConsMDFeNaoEnc: TMDFeConsultaMDFeNaoEnc;
    FDistribuicaoDFe: TDistribuicaoDFe;
    FEnvioWebService: TMDFeEnvioWebService;
  public
    constructor Create(AOwner: TACBrDFe); overload;
    destructor Destroy; override;

    function Envia(ALote: Integer): Boolean; overload;
    function Envia(ALote: String): Boolean; overload;
    function ConsultaMDFeNaoEnc(ACNPJ: String): Boolean;

    property ACBrMDFe: TACBrDFe read FACBrMDFe write FACBrMDFe;
    property StatusServico: TMDFeStatusServico read FStatusServico write FStatusServico;
    property Enviar: TMDFeRecepcao read FEnviar write FEnviar;
    property Retorno: TMDFeRetRecepcao read FRetorno write FRetorno;
    property Recibo: TMDFeRecibo read FRecibo write FRecibo;
    property Consulta: TMDFeConsulta read FConsulta write FConsulta;
    property EnvEvento: TMDFeEnvEvento read FEnvEvento write FEnvEvento;
    property ConsMDFeNaoEnc: TMDFeConsultaMDFeNaoEnc read FConsMDFeNaoEnc write FConsMDFeNaoEnc;
    property DistribuicaoDFe: TDistribuicaoDFe read FDistribuicaoDFe write FDistribuicaoDFe;
    property EnvioWebService: TMDFeEnvioWebService read FEnvioWebService write FEnvioWebService;
  end;

implementation

uses
  StrUtils, Math,
  ACBrUtil, ACBrMDFe,
  pcnGerador, pmdfeConsStatServ, pmdfeRetConsStatServ,
  pmdfeConsSitMDFe, pmdfeConsReciMDFe, pmdfeConsMDFeNaoEnc,
  pcnLeitor, pmdfeMDFeW;

{ TMDFeWebService }

constructor TMDFeWebService.Create(AOwner: TACBrDFe);
begin
  inherited Create(AOwner);

  FPConfiguracoesMDFe := TConfiguracoesMDFe(FPConfiguracoes);
  FPLayout := LayMDFeStatusServico;

  FPHeaderElement := 'mdfeCabecMsg';
  FPBodyElement := 'mdfeDadosMsg';
end;

procedure TMDFeWebService.Clear;
begin
  inherited Clear;

  FPStatus := stMDFeIdle;
end;

function TMDFeWebService.ExtrairModeloChaveAcesso(AChaveMDFe: String): String;
begin
  AChaveMDFe := OnlyNumber(AChaveMDFe);
  if ValidarChave(AChaveMDFe) then
    Result := copy(AChaveMDFe, 21, 2)
  else
    Result := '';
end;

procedure TMDFeWebService.InicializarServico;
begin
  { Sobrescrever apenas se necess�rio }
  inherited InicializarServico;

  TACBrMDFe(FPDFeOwner).SetStatus(FPStatus);
end;

procedure TMDFeWebService.DefinirURL;
var
  Versao: Double;
begin
  { sobrescrever apenas se necess�rio.
    Voc� tamb�m pode mudar apenas o valor de "FLayoutServico" na classe
    filha e chamar: Inherited;     }

  Versao := 0;
  FPVersaoServico := '';
  FPURL := '';

  TACBrMDFe(FPDFeOwner).LerServicoDeParams(FPLayout, Versao, FPURL);
  FPVersaoServico := FloatToString(Versao, '.', '0.00');
end;

function TMDFeWebService.GerarVersaoDadosSoap: String;
begin
  { Sobrescrever apenas se necess�rio }

  if EstaVazio(FPVersaoServico) then
    FPVersaoServico := TACBrMDFe(FPDFeOwner).LerVersaoDeParams(FPLayout);

  Result := '<versaoDados>' + FPVersaoServico + '</versaoDados>';
end;

procedure TMDFeWebService.FinalizarServico;
begin
  { Sobrescrever apenas se necess�rio }

  TACBrMDFe(FPDFeOwner).SetStatus(stMDFeIdle);
end;

function TMDFeWebService.ExtrairUFChaveAcesso(AChaveMDFe: String): Integer;
begin
  Result := StrToIntDef(Copy(AChaveMDFe, 1, 2), 0);
end;

{ TMDFeStatusServico }

procedure TMDFeStatusServico.Clear;
begin
  inherited Clear;

  FPStatus := stMDFeStatusServico;
  FPLayout := LayMDFeStatusServico;
  FPArqEnv := 'ped-sta';
  FPArqResp := 'sta';

  Fversao := '';
  FverAplic := '';
  FcStat := 0;
  FxMotivo := '';
  FdhRecbto := 0;
  FTMed := 0;
  FdhRetorno := 0;
  FxObs := '';

  if Assigned(FPConfiguracoesMDFe) then
  begin
    FtpAmb := FPConfiguracoesMDFe.WebServices.Ambiente;
    FcUF := FPConfiguracoesMDFe.WebServices.UFCodigo;
  end
end;

procedure TMDFeStatusServico.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'MDFeStatusServico';
  FPSoapAction := FPServico + '/mdfeStatusServicoMDF';
end;

procedure TMDFeStatusServico.DefinirDadosMsg;
var
  ConsStatServ: TConsStatServ;
begin
  ConsStatServ := TConsStatServ.Create;
  try
    ConsStatServ.TpAmb := FPConfiguracoesMDFe.WebServices.Ambiente;
    ConsStatServ.CUF := FPConfiguracoesMDFe.WebServices.UFCodigo;
    ConsStatServ.Versao := FPVersaoServico;
    ConsStatServ.GerarXML;

    // Atribuindo o XML para propriedade interna //
    FPDadosMsg := ConsStatServ.Gerador.ArquivoFormatoXML;
  finally
    ConsStatServ.Free;
  end;
end;

function TMDFeStatusServico.TratarResposta: Boolean;
var
  MDFeRetorno: TRetConsStatServ;
begin
  FPRetWS := SeparaDados(FPRetornoWS, 'mdfeStatusServicoMDFResult');

  MDFeRetorno := TRetConsStatServ.Create;
  try
    MDFeRetorno.Leitor.Arquivo := FPRetWS;
    MDFeRetorno.LerXml;

    Fversao := MDFeRetorno.versao;
    FtpAmb := MDFeRetorno.tpAmb;
    FverAplic := MDFeRetorno.verAplic;
    FcStat := MDFeRetorno.cStat;
    FxMotivo := MDFeRetorno.xMotivo;
    FcUF := MDFeRetorno.cUF;
    FdhRecbto := MDFeRetorno.dhRecbto;
    FTMed := MDFeRetorno.TMed;
    FdhRetorno := MDFeRetorno.dhRetorno;
    FxObs := MDFeRetorno.xObs;
    FPMsg := FxMotivo + LineBreak + FxObs;

    if FPConfiguracoesMDFe.WebServices.AjustaAguardaConsultaRet then
      FPConfiguracoesMDFe.WebServices.AguardarConsultaRet := FTMed * 1000;

    Result := (FcStat = 107);

  finally
    MDFeRetorno.Free;
  end;
end;

function TMDFeStatusServico.GerarMsgLog: String;
begin
  Result := Format(ACBrStr('Vers�o Layout: %s ' + LineBreak +
                           'Ambiente: %s' + LineBreak +
                           'Vers�o Aplicativo: %s ' + LineBreak +
                           'Status C�digo: %s' + LineBreak +
                           'Status Descri��o: %s' + LineBreak +
                           'UF: %s' + LineBreak +
                           'Recebimento: %s' + LineBreak +
                           'Tempo M�dio: %s' + LineBreak +
                           'Retorno: %s' + LineBreak +
                           'Observa��o: %s' + LineBreak),
                   [Fversao, TpAmbToStr(FtpAmb), FverAplic, IntToStr(FcStat),
                    FxMotivo, CodigoParaUF(FcUF),
                    IfThen(FdhRecbto = 0, '', FormatDateTimeBr(FdhRecbto)),
                    IntToStr(FTMed),
                    IfThen(FdhRetorno = 0, '', FormatDateTimeBr(FdhRetorno)),
                    FxObs]);
end;

function TMDFeStatusServico.GerarMsgErro(E: Exception): String;
begin
  Result := ACBrStr('WebService Consulta Status servi�o:' + LineBreak +
                    '- Inativo ou Inoperante tente novamente.');
end;

{ TMDFeRecepcao }

constructor TMDFeRecepcao.Create(AOwner: TACBrDFe; AManifestos: TManifestos);
begin
  inherited Create(AOwner);

  FManifestos := AManifestos;
end;

destructor TMDFeRecepcao.Destroy;
begin
  FMDFeRetorno.Free;

  inherited Destroy;
end;

procedure TMDFeRecepcao.Clear;
begin
  inherited Clear;

  FPStatus := stMDFeRecepcao;
  FPLayout := LayMDFeRecepcao;
  FPArqEnv := 'env-lot';
  FPArqResp := 'rec';

  Fversao := '';
  FTMed := 0;
  FverAplic := '';
  FcStat    := 0;
  FxMotivo  := '';
  FRecibo   := '';
  FdhRecbto := 0;

  if Assigned(FPConfiguracoesMDFe) then
  begin
    FtpAmb := FPConfiguracoesMDFe.WebServices.Ambiente;
    FcUF := FPConfiguracoesMDFe.WebServices.UFCodigo;
  end;

  if Assigned(FMDFeRetorno) then
    FMDFeRetorno.Free;

  FMDFeRetorno := TretEnvMDFe.Create;
end;

function TMDFeRecepcao.GetLote: String;
begin
  Result := Trim(FLote);
end;

function TMDFeRecepcao.GetRecibo: String;
begin
  Result := Trim(FRecibo);
end;

procedure TMDFeRecepcao.DefinirURL;
var
  Modelo: String;
  VerServ: Double;
begin
  FPLayout := LayMDFeRecepcao;

  if FManifestos.Count > 0 then    // Tem MDFe ? Se SIM, use as informa��es do XML
  begin
    FcUF    := FManifestos.Items[0].MDFe.Ide.cUF;
    VerServ := FManifestos.Items[0].MDFe.infMDFe.Versao;

    if FPConfiguracoesMDFe.WebServices.Ambiente <> FManifestos.Items[0].MDFe.Ide.tpAmb then
      raise EACBrMDFeException.Create( ACBRMDFE_CErroAmbDiferente );
  end
  else
  begin                              // Se n�o tem MDFe, use as configura��es do componente
    FcUF    := FPConfiguracoesMDFe.WebServices.UFCodigo;
    VerServ := VersaoMDFeToDbl(FPConfiguracoesMDFe.Geral.VersaoDF);
  end;

  Modelo := 'MDFe';
  FTpAmb := FPConfiguracoesMDFe.WebServices.Ambiente;
  FPVersaoServico := '';
  FPURL := '';

  TACBrMDFe(FPDFeOwner).LerServicoDeParams(
    Modelo,
    CUFtoUF(FcUF),
    FTpAmb,
    LayOutToServico(FPLayout),
    VerServ,
    FPURL
  );

  FPVersaoServico := FloatToString(VerServ, '.', '0.00');
end;

procedure TMDFeRecepcao.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'MDFeRecepcao';
  FPSoapAction := FPServico + '/mdfeRecepcaoLote';
end;

procedure TMDFeRecepcao.DefinirDadosMsg;
var
  I: Integer;
  vMDFe: String;
begin
  vMDFe := '';
  for I := 0 to FManifestos.Count - 1 do
    vMDFe := vMDFe + '<MDFe' + RetornarConteudoEntre(
      FManifestos.Items[I].XMLAssinado, '<MDFe', '</MDFe>') + '</MDFe>';

  FPDadosMsg := '<enviMDFe xmlns="' + ACBRMDFE_NAMESPACE + '" versao="' +
    FPVersaoServico + '">' + '<idLote>' + FLote + '</idLote>' +
    vMDFe + '</enviMDFe>';

  // Lote tem mais de 500kb ? //
  if Length(FPDadosMsg) > (500 * 1024) then
    GerarException(ACBrStr('Tamanho do XML de Dados superior a 500 Kbytes. Tamanho atual: ' +
      IntToStr(trunc(Length(FPDadosMsg) / 1024)) + ' Kbytes'));

  FRecibo := '';
end;

function TMDFeRecepcao.TratarResposta: Boolean;
begin
  FPRetWS := SeparaDados(FPRetornoWS, 'mdfeRecepcaoLoteResult');

  FMDFeRetorno.Leitor.Arquivo := FPRetWS;
  FMDFeRetorno.LerXml;

  Fversao := FMDFeRetorno.versao;
  FTpAmb := FMDFeRetorno.TpAmb;
  FverAplic := FMDFeRetorno.verAplic;
  FcStat := FMDFeRetorno.cStat;
  FxMotivo := FMDFeRetorno.xMotivo;
  FdhRecbto := FMDFeRetorno.infRec.dhRecbto;
  FTMed := FMDFeRetorno.infRec.tMed;
  FcUF := FMDFeRetorno.cUF;
  FPMsg := FMDFeRetorno.xMotivo;
  FRecibo := FMDFeRetorno.infRec.nRec;

  Result := (FMDFeRetorno.CStat = 103);
end;

function TMDFeRecepcao.GerarMsgLog: String;
begin
  Result := Format(ACBrStr('Vers�o Layout: %s ' + LineBreak +
                           'Ambiente: %s ' + LineBreak +
                           'Vers�o Aplicativo: %s ' + LineBreak +
                           'Status C�digo: %s ' + LineBreak +
                           'Status Descri��o: %s ' + LineBreak +
                           'UF: %s ' + sLineBreak +
                           'Recibo: %s ' + LineBreak +
                           'Recebimento: %s ' + LineBreak +
                           'Tempo M�dio: %s ' + LineBreak),
                     [FMDFeRetorno.versao,
                      TpAmbToStr(FMDFeRetorno.TpAmb),
                      FMDFeRetorno.verAplic,
                      IntToStr(FMDFeRetorno.cStat),
                      FMDFeRetorno.xMotivo,
                      CodigoParaUF(FMDFeRetorno.cUF),
                      FMDFeRetorno.infRec.nRec,
                      IfThen(FMDFeRetorno.InfRec.dhRecbto = 0, '',
                             FormatDateTimeBr(FMDFeRetorno.InfRec.dhRecbto)),
                      IntToStr(FMDFeRetorno.InfRec.TMed)]);
end;

function TMDFeRecepcao.GerarPrefixoArquivo: String;
begin
  Result := Lote;
end;

{ TMDFeRetRecepcao }

constructor TMDFeRetRecepcao.Create(AOwner: TACBrDFe; AManifestos: TManifestos);
begin
  inherited Create(AOwner);

  FManifestos := AManifestos;
end;

destructor TMDFeRetRecepcao.Destroy;
begin
  FMDFeRetorno.Free;

  inherited Destroy;
end;

procedure TMDFeRetRecepcao.Clear;
var
  i, j: Integer;
begin
  inherited Clear;

  FPStatus := stMDFeRetRecepcao;
  FPLayout := LayMDFeRetRecepcao;
  FPArqEnv := 'ped-rec';
  FPArqResp := 'pro-rec';

  FverAplic := '';
  FcStat := 0;
  FxMotivo := '';
  Fversao := '';
  FxMsg := '';
  FcMsg := 0;

  if Assigned(FPConfiguracoesMDFe) then
  begin
    FtpAmb := FPConfiguracoesMDFe.WebServices.Ambiente;
    FcUF := FPConfiguracoesMDFe.WebServices.UFCodigo;
  end;

  if Assigned(FMDFeRetorno) and Assigned(FManifestos) then
  begin
    // Limpa Dados dos retornos dos manifestos
    for i := 0 to FMDFeRetorno.ProtMDFe.Count - 1 do
    begin
      for j := 0 to FManifestos.Count - 1 do
      begin
        if OnlyNumber(FMDFeRetorno.ProtMDFe.Items[i].chMDFe) = FManifestos.Items[J].NumID then
        begin
          FManifestos.Items[j].MDFe.procMDFe.verAplic := '';
          FManifestos.Items[j].MDFe.procMDFe.chMDFe   := '';
          FManifestos.Items[j].MDFe.procMDFe.dhRecbto := 0;
          FManifestos.Items[j].MDFe.procMDFe.nProt    := '';
          FManifestos.Items[j].MDFe.procMDFe.digVal   := '';
          FManifestos.Items[j].MDFe.procMDFe.cStat    := 0;
          FManifestos.Items[j].MDFe.procMDFe.xMotivo  := '';
        end;
      end;
    end;

    FreeAndNil(FMDFeRetorno);
  end;

  FMDFeRetorno := TRetConsReciMDFe.Create;
end;

function TMDFeRetRecepcao.GetRecibo: String;
begin
  Result := Trim(FRecibo);
end;

function TMDFeRetRecepcao.Executar: Boolean;
var
  IntervaloTentativas, Tentativas: Integer;
begin
  Result := False;

  TACBrMDFe(FPDFeOwner).SetStatus(stMDFeRetRecepcao);
  try
    Sleep(FPConfiguracoesMDFe.WebServices.AguardarConsultaRet);

    Tentativas := 0; // Inicializa o contador de tentativas
    IntervaloTentativas := max(FPConfiguracoesMDFe.WebServices.IntervaloTentativas, 1000);

    while (inherited Executar) and
      (Tentativas < FPConfiguracoesMDFe.WebServices.Tentativas) do
    begin
      Inc(Tentativas);
      sleep(IntervaloTentativas);
    end;
  finally
    TACBrMDFe(FPDFeOwner).SetStatus(stMDFeIdle);
  end;

  if FMDFeRetorno.CStat = 104 then  // Lote processado ?
    Result := TratarRespostaFinal;
end;

procedure TMDFeRetRecepcao.DefinirURL;
var
  Modelo: String;
  VerServ: Double;
begin
  FPLayout := LayMDFeRetRecepcao;

  if FManifestos.Count > 0 then    // Tem MDFe ? Se SIM, use as informa��es do XML
  begin
    FcUF    := FManifestos.Items[0].MDFe.Ide.cUF;
    VerServ := FManifestos.Items[0].MDFe.infMDFe.Versao;

    if FPConfiguracoesMDFe.WebServices.Ambiente <> FManifestos.Items[0].MDFe.Ide.tpAmb then
      raise EACBrMDFeException.Create( ACBRMDFE_CErroAmbDiferente );
  end
  else
  begin                              // Se n�o tem MDFe, use as configura��es do componente
    FcUF    := FPConfiguracoesMDFe.WebServices.UFCodigo;
    VerServ := VersaoMDFeToDbl(FPConfiguracoesMDFe.Geral.VersaoDF);
  end;

  Modelo := 'MDFe';
  FTpAmb := FPConfiguracoesMDFe.WebServices.Ambiente;
  FPVersaoServico := '';
  FPURL := '';

  TACBrMDFe(FPDFeOwner).LerServicoDeParams(
    Modelo,
    CUFtoUF(FcUF),
    FTpAmb,
    LayOutToServico(FPLayout),
    VerServ,
    FPURL
  );

  FPVersaoServico := FloatToString(VerServ, '.', '0.00');
end;

procedure TMDFeRetRecepcao.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'MDFeRetRecepcao';
  FPSoapAction := FPServico + '/mdfeRetRecepcao';
end;

procedure TMDFeRetRecepcao.DefinirDadosMsg;
var
  ConsReciMDFe: TConsReciMDFe;
begin
  ConsReciMDFe := TConsReciMDFe.Create;
  try
    ConsReciMDFe.tpAmb := FPConfiguracoesMDFe.WebServices.Ambiente;
    ConsReciMDFe.nRec := FRecibo;
    ConsReciMDFe.Versao := FPVersaoServico;
    ConsReciMDFe.GerarXML;

    FPDadosMsg := ConsReciMDFe.Gerador.ArquivoFormatoXML;
  finally
    ConsReciMDFe.Free;
  end;
end;

function TMDFeRetRecepcao.TratarResposta: Boolean;
begin
  FPRetWS := SeparaDados(FPRetornoWS, 'mdfeRetRecepcaoResult');

  FMDFeRetorno.Leitor.Arquivo := FPRetWS;
  FMDFeRetorno.LerXML;

  Fversao := FMDFeRetorno.versao;
  FTpAmb := FMDFeRetorno.TpAmb;
  FverAplic := FMDFeRetorno.verAplic;
  FcStat := FMDFeRetorno.cStat;
  FcUF := FMDFeRetorno.cUF;
  FPMsg := FMDFeRetorno.xMotivo;
  FxMotivo := FMDFeRetorno.xMotivo;
  FcMsg := FMDFeRetorno.cMsg;
  FxMsg := FMDFeRetorno.xMsg;

  Result := (FMDFeRetorno.CStat = 105); // Lote em Processamento
end;

function TMDFeRetRecepcao.TratarRespostaFinal: Boolean;
var
  I, J: Integer;
  AProcMDFe: TProcMDFe;
  AInfProt: TProtMDFeCollection;
  SalvarXML: Boolean;
begin
  Result := False;

  AInfProt := FMDFeRetorno.ProtMDFe;

  if (AInfProt.Count > 0) then
  begin
    FPMsg := FMDFeRetorno.ProtMDFe.Items[0].xMotivo;
    FxMotivo := FMDFeRetorno.ProtMDFe.Items[0].xMotivo;
  end;

  //Setando os retornos dos Manifestos;
  for I := 0 to AInfProt.Count - 1 do
  begin
    for J := 0 to FManifestos.Count - 1 do
    begin
      if OnlyNumber(AInfProt.Items[I].chMDFe) = FManifestos.Items[J].NumID then
      begin
        if (TACBrMDFe(FPDFeOwner).Configuracoes.Geral.ValidarDigest) and
          (FManifestos.Items[J].MDFe.signature.DigestValue <>
          AInfProt.Items[I].digVal) and (AInfProt.Items[I].digVal <> '') then
        begin
          raise EACBrMDFeException.Create('DigestValue do documento ' +
            FManifestos.Items[J].NumID + ' n�o confere.');
        end;

        with FManifestos.Items[J] do
        begin
          MDFe.procMDFe.tpAmb := AInfProt.Items[I].tpAmb;
          MDFe.procMDFe.verAplic := AInfProt.Items[I].verAplic;
          MDFe.procMDFe.chMDFe := AInfProt.Items[I].chMDFe;
          MDFe.procMDFe.dhRecbto := AInfProt.Items[I].dhRecbto;
          MDFe.procMDFe.nProt := AInfProt.Items[I].nProt;
          MDFe.procMDFe.digVal := AInfProt.Items[I].digVal;
          MDFe.procMDFe.cStat := AInfProt.Items[I].cStat;
          MDFe.procMDFe.xMotivo := AInfProt.Items[I].xMotivo;
        end;

        // Monta o XML do MDF-e assinado e com o protocolo de Autoriza��o
        if (AInfProt.Items[I].cStat = 100) then
        begin
          AProcMDFe := TProcMDFe.Create;
          try
            AProcMDFe.XML_MDFe := StringReplace(FManifestos.Items[J].XMLAssinado,
                                       '<' + ENCODING_UTF8 + '>', '',
                                       [rfReplaceAll]);
            AProcMDFe.XML_Prot := AInfProt.Items[I].XMLprotMDFe;
            AProcMDFe.Versao := FPVersaoServico;
            AProcMDFe.GerarXML;

            with FManifestos.Items[J] do
            begin
              XMLOriginal := AProcMDFe.Gerador.ArquivoFormatoXML;

              if FPConfiguracoesMDFe.Arquivos.Salvar then
              begin
                SalvarXML := (not FPConfiguracoesMDFe.Arquivos.SalvarApenasMDFeProcessados) or
                             Processado;

                // Salva o XML do MDF-e assinado e protocolado
                if SalvarXML then
                  FPDFeOwner.Gravar(AInfProt.Items[I].chMDFe + '-mdfe.xml',
                                    XMLOriginal,
                                    PathWithDelim(FPConfiguracoesMDFe.Arquivos.GetPathMDFe(0)));
              end;
            end;
          finally
            AProcMDFe.Free;
          end;
        end;

        break;
      end;
    end;
  end;

  //Verificando se existe algum Manifesto confirmado
  for I := 0 to FManifestos.Count - 1 do
  begin
    if FManifestos.Items[I].Confirmado then
    begin
      Result := True;
      break;
    end;
  end;

  //Verificando se existe algum Manifesto nao confirmado
  for I := 0 to FManifestos.Count - 1 do
  begin
    if not FManifestos.Items[I].Confirmado then
    begin
      FPMsg := ACBrStr('Manifesto(s) n�o confirmado(s):') + LineBreak;
      break;
    end;
  end;

  //Montando a mensagem de retorno para os Manifestos nao confirmados
  for I := 0 to FManifestos.Count - 1 do
  begin
    if not FManifestos.Items[I].Confirmado then
      FPMsg := FPMsg + IntToStr(FManifestos.Items[I].MDFe.Ide.nMDF) +
        '->' + FManifestos.Items[I].Msg + LineBreak;
  end;

  if AInfProt.Count > 0 then
  begin
    FChaveMDFe := AInfProt.Items[0].chMDFe;
    FProtocolo := AInfProt.Items[0].nProt;
    FcStat := AInfProt.Items[0].cStat;
  end;
end;

procedure TMDFeRetRecepcao.FinalizarServico;
begin
  // Sobrescrito, para n�o liberar para stIdle... n�o ainda...;
end;

function TMDFeRetRecepcao.GerarMsgLog: String;
begin
  Result := Format(ACBrStr('Vers�o Layout: %s ' + LineBreak +
                           'Ambiente: %s ' + LineBreak +
                           'Vers�o Aplicativo: %s ' + LineBreak +
                           'Recibo: %s ' + LineBreak +
                           'Status C�digo: %s ' + LineBreak +
                           'Status Descri��o: %s ' + LineBreak +
                           'UF: %s ' + LineBreak +
                           'cMsg: %s ' + LineBreak +
                           'xMsg: %s ' + LineBreak),
                   [FMDFeRetorno.versao, TpAmbToStr(FMDFeRetorno.tpAmb),
                    FMDFeRetorno.verAplic, FMDFeRetorno.nRec,
                    IntToStr(FMDFeRetorno.cStat), FMDFeRetorno.xMotivo,
                    CodigoParaUF(FMDFeRetorno.cUF), IntToStr(FMDFeRetorno.cMsg),
                    FMDFeRetorno.xMsg]);
end;

function TMDFeRetRecepcao.GerarPrefixoArquivo: String;
begin
  Result := Recibo;
end;

{ TMDFeRecibo }

constructor TMDFeRecibo.Create(AOwner: TACBrDFe; AManifestos: TManifestos);
begin
  inherited Create(AOwner);

  FManifestos := AManifestos;
  FMDFeRetorno := TRetConsReciMDFe.Create;
end;

destructor TMDFeRecibo.Destroy;
begin
  FMDFeRetorno.Free;

  inherited Destroy;
end;

procedure TMDFeRecibo.Clear;
begin
  inherited Clear;

  FPStatus := stMDFeRecibo;
  FPLayout := LayMDFeRetRecepcao;
  FPArqEnv := 'ped-rec';
  FPArqResp := 'pro-rec';

  Fversao := '';
  FxMsg := '';
  FcMsg := 0;
  FverAplic := '';
  FcStat    := 0;
  FxMotivo  := '';

  if Assigned(FPConfiguracoesMDFe) then
  begin
    FtpAmb := FPConfiguracoesMDFe.WebServices.Ambiente;
    FcUF := FPConfiguracoesMDFe.WebServices.UFCodigo;
  end;

  if Assigned(FMDFeRetorno) then
    FMDFeRetorno.Free;

  FMDFeRetorno := TRetConsReciMDFe.Create;
end;

procedure TMDFeRecibo.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'MDFeRetRecepcao';
  FPSoapAction := FPServico + '/mdfeRetRecepcao';
end;

procedure TMDFeRecibo.DefinirURL;
var
  Modelo: String;
  VerServ: Double;
begin
  FPLayout := LayMDFeRetRecepcao;

  if FManifestos.Count > 0 then    // Tem MDFe ? Se SIM, use as informa��es do XML
  begin
    FcUF    := FManifestos.Items[0].MDFe.Ide.cUF;
    VerServ := FManifestos.Items[0].MDFe.infMDFe.Versao;

    if FPConfiguracoesMDFe.WebServices.Ambiente <> FManifestos.Items[0].MDFe.Ide.tpAmb then
      raise EACBrMDFeException.Create( ACBRMDFE_CErroAmbDiferente );
  end
  else
  begin                              // Se n�o tem MDFe, use as configura��es do componente
    FcUF    := FPConfiguracoesMDFe.WebServices.UFCodigo;
    VerServ := VersaoMDFeToDbl(FPConfiguracoesMDFe.Geral.VersaoDF);
  end;

  Modelo := 'MDFe';
  FTpAmb := FPConfiguracoesMDFe.WebServices.Ambiente;
  FPVersaoServico := '';
  FPURL := '';

  TACBrMDFe(FPDFeOwner).LerServicoDeParams(
    Modelo,
    CUFtoUF(FcUF),
    FTpAmb,
    LayOutToServico(FPLayout),
    VerServ,
    FPURL
  );

  FPVersaoServico := FloatToString(VerServ, '.', '0.00');
end;

procedure TMDFeRecibo.DefinirDadosMsg;
var
  ConsReciMDFe: TConsReciMDFe;
begin
  ConsReciMDFe := TConsReciMDFe.Create;
  try
    ConsReciMDFe.tpAmb := FTpAmb;
    ConsReciMDFe.nRec := FRecibo;
    ConsReciMDFe.Versao := FPVersaoServico;
    ConsReciMDFe.GerarXML;

    FPDadosMsg := ConsReciMDFe.Gerador.ArquivoFormatoXML;
  finally
    ConsReciMDFe.Free;
  end;
end;

function TMDFeRecibo.TratarResposta: Boolean;
begin
  FPRetWS := SeparaDados(FPRetornoWS, 'mdfeRetRecepcaoResult');

  FMDFeRetorno.Leitor.Arquivo := FPRetWS;
  FMDFeRetorno.LerXML;

  Fversao := FMDFeRetorno.versao;
  FTpAmb := FMDFeRetorno.TpAmb;
  FverAplic := FMDFeRetorno.verAplic;
  FcStat := FMDFeRetorno.cStat;
  FxMotivo := FMDFeRetorno.xMotivo;
  FcUF := FMDFeRetorno.cUF;
  FxMsg := FMDFeRetorno.xMsg;
  FcMsg := FMDFeRetorno.cMsg;
  FPMsg := FxMotivo;

  Result := (FMDFeRetorno.CStat = 104);
end;

function TMDFeRecibo.GerarMsgLog: String;
begin
  Result := Format(ACBrStr('Vers�o Layout: %s ' + LineBreak +
                           'Ambiente: %s ' + LineBreak +
                           'Vers�o Aplicativo: %s ' + LineBreak +
                           'Recibo: %s ' + LineBreak +
                           'Status C�digo: %s ' + LineBreak +
                           'Status Descri��o: %s ' + LineBreak +
                           'UF: %s ' + LineBreak),
                   [FMDFeRetorno.versao, TpAmbToStr(FMDFeRetorno.TpAmb),
                   FMDFeRetorno.verAplic, FMDFeRetorno.nRec,
                   IntToStr(FMDFeRetorno.cStat),
                   FMDFeRetorno.xMotivo,
                   CodigoParaUF(FMDFeRetorno.cUF)]);
end;

{ TMDFeConsulta }

constructor TMDFeConsulta.Create(AOwner: TACBrDFe; AManifestos: TManifestos);
begin
  inherited Create(AOwner);

  FOwner := AOwner;
  FManifestos := AManifestos;
end;

destructor TMDFeConsulta.Destroy;
begin
  FprotMDFe.Free;
  FprocEventoMDFe.Free;

  inherited Destroy;
end;

procedure TMDFeConsulta.Clear;
begin
  inherited Clear;

  FPStatus := stMDFeConsulta;
  FPLayout := LayMDFeConsulta;
  FPArqEnv := 'ped-sit';
  FPArqResp := 'sit';

  FverAplic := '';
  FcStat := 0;
  FxMotivo := '';
  FProtocolo := '';
  FDhRecbto := 0;
  Fversao := '';
  FRetMDFeDFe := '';

  if Assigned(FPConfiguracoesMDFe) then
  begin
    FtpAmb := FPConfiguracoesMDFe.WebServices.Ambiente;
    FcUF := FPConfiguracoesMDFe.WebServices.UFCodigo;
  end;

  if Assigned(FprotMDFe) then
    FprotMDFe.Free;

  if Assigned(FprocEventoMDFe) then
    FprocEventoMDFe.Free;

  FprotMDFe := TProcMDFe.Create;
  FprocEventoMDFe := TRetEventoMDFeCollection.Create(FOwner);
end;

procedure TMDFeConsulta.DefinirURL;
var
  VerServ: Double;
  Modelo: String;
begin
  FPVersaoServico := '';
  FPURL  := '';
  Modelo := 'MDFe';
  FcUF   := ExtrairUFChaveAcesso(FMDFeChave);

  if FManifestos.Count > 0 then
  begin
    FTpAmb  := FManifestos.Items[0].MDFe.Ide.tpAmb;
    VerServ := FManifestos.Items[0].MDFe.infMDFe.Versao;
  end
  else
  begin
    FTpAmb  := FPConfiguracoesMDFe.WebServices.Ambiente;
    VerServ := VersaoMDFeToDbl(FPConfiguracoesMDFe.Geral.VersaoDF);
  end;

  TACBrMDFe(FPDFeOwner).LerServicoDeParams(
    Modelo,
    CUFtoUF(FcUF),
    FTpAmb,
    LayOutToServico(FPLayout),
    VerServ,
    FPURL
  );

  FPVersaoServico := FloatToString(VerServ, '.', '0.00');
end;

procedure TMDFeConsulta.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'MDFeConsulta';
  FPSoapAction := FPServico + '/mdfeConsultaMDF';
end;

procedure TMDFeConsulta.DefinirDadosMsg;
var
  ConsSitMDFe: TConsSitMDFe;
begin
  ConsSitMDFe := TConsSitMDFe.Create;
  try
    ConsSitMDFe.TpAmb := FTpAmb;
    ConsSitMDFe.chMDFe := FMDFeChave;
    ConsSitMDFe.Versao := FPVersaoServico;
    ConsSitMDFe.GerarXML;

    FPDadosMsg := ConsSitMDFe.Gerador.ArquivoFormatoXML;
  finally
    ConsSitMDFe.Free;
  end;
end;

function TMDFeConsulta.GerarUFSoap: String;
begin
  Result := '<cUF>' + IntToStr(FcUF) + '</cUF>';
end;

function TMDFeConsulta.TratarResposta: Boolean;
var
  MDFeRetorno: TRetConsSitMDFe;
  SalvarXML, MDFCancelado, Atualiza: Boolean;
  aEventos: String;
  AProcMDFe: TProcMDFe;
  I, J, Inicio, Fim: Integer;
  Data: TDateTime;
begin
  MDFeRetorno := TRetConsSitMDFe.Create;

  try
    FPRetWS := SeparaDados(FPRetornoWS, 'mdfeConsultaMDFResult');

    MDFeRetorno.Leitor.Arquivo := FPRetWS;
    MDFeRetorno.LerXML;

    MDFCancelado := False;
    aEventos := '';

    // <retConsSitMDFe> - Retorno da consulta da situa��o da NF-e
    // Este � o status oficial da NF-e
    Fversao := MDFeRetorno.versao;
    FTpAmb := MDFeRetorno.tpAmb;
    FverAplic := MDFeRetorno.verAplic;
    FcStat := MDFeRetorno.cStat;
    FXMotivo := MDFeRetorno.xMotivo;
    FcUF := MDFeRetorno.cUF;
    FMDFeChave := MDFeRetorno.chMDFe;
    FPMsg := FXMotivo;

    // <protMDFe> - Retorno dos dados do ENVIO da NF-e
    // Consider�-los apenas se n�o existir nenhum evento de cancelamento (110111)
    FprotMDFe.PathMDFe := MDFeRetorno.protMDFe.PathMDFe;
    FprotMDFe.PathRetConsReciMDFe := MDFeRetorno.protMDFe.PathRetConsReciMDFe;
    FprotMDFe.PathRetConsSitMDFe := MDFeRetorno.protMDFe.PathRetConsSitMDFe;
    FprotMDFe.PathRetConsSitMDFe := MDFeRetorno.protMDFe.PathRetConsSitMDFe;
    FprotMDFe.tpAmb := MDFeRetorno.protMDFe.tpAmb;
    FprotMDFe.verAplic := MDFeRetorno.protMDFe.verAplic;
    FprotMDFe.chMDFe := MDFeRetorno.protMDFe.chMDFe;
    FprotMDFe.dhRecbto := MDFeRetorno.protMDFe.dhRecbto;
    FprotMDFe.nProt := MDFeRetorno.protMDFe.nProt;
    FprotMDFe.digVal := MDFeRetorno.protMDFe.digVal;
    FprotMDFe.cStat := MDFeRetorno.protMDFe.cStat;
    FprotMDFe.xMotivo := MDFeRetorno.protMDFe.xMotivo;

    if Assigned(MDFeRetorno.procEventoMDFe) and (MDFeRetorno.procEventoMDFe.Count > 0) then
    begin
      aEventos := '=====================================================' +
        LineBreak + '================== Eventos da MDF-e ==================' +
        LineBreak + '=====================================================' +
        LineBreak + '' + LineBreak + 'Quantidade total de eventos: ' +
        IntToStr(MDFeRetorno.procEventoMDFe.Count);

      FprocEventoMDFe.Clear;
      for I := 0 to MDFeRetorno.procEventoMDFe.Count - 1 do
      begin
        with FprocEventoMDFe.Add.RetEventoMDFe do
        begin
          idLote := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.idLote;
          tpAmb := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.tpAmb;
          verAplic := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.verAplic;
          cOrgao := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.cOrgao;
          cStat := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.cStat;
          xMotivo := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.xMotivo;
          XML := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.XML;

          Infevento.ID              := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.ID;
          Infevento.tpAmb           := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.tpAmb;
          InfEvento.CNPJ            := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.CNPJ;
          InfEvento.chMDFe          := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.chMDFe;
          InfEvento.dhEvento        := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.dhEvento;
          InfEvento.TpEvento        := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.TpEvento;
          InfEvento.nSeqEvento      := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.nSeqEvento;
          InfEvento.VersaoEvento    := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.VersaoEvento;
          InfEvento.DetEvento.nProt := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.DetEvento.nProt;
          InfEvento.DetEvento.xJust := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.DetEvento.xJust;
          InfEvento.DetEvento.xNome := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.DetEvento.xNome;
          InfEvento.DetEvento.CPF   := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.DetEvento.CPF;

          retEvento.Clear;
          for J := 0 to MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Count-1 do
          begin
            with retEvento.Add.RetInfEvento do
            begin
              Id          := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.Id;
              tpAmb       := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.tpAmb;
              verAplic    := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.verAplic;
              cOrgao      := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.cOrgao;
              cStat       := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.cStat;
              xMotivo     := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.xMotivo;
              chMDFe      := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.chMDFe;
              tpEvento    := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.tpEvento;
              xEvento     := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.xEvento;
              nSeqEvento  := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.nSeqEvento;
              CNPJDest    := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.CNPJDest;
              emailDest   := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.emailDest;
              dhRegEvento := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.dhRegEvento;
              nProt       := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.nProt;
              XML         := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.XML;
            end;
          end;
        end;

        with MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe do
        begin
          for j := 0 to retEvento.Count -1 do
          begin
            aEventos := aEventos + LineBreak + LineBreak +
              Format(ACBrStr('N�mero de sequ�ncia: %s ' + LineBreak +
                             'C�digo do evento: %s ' + LineBreak +
                             'Descri��o do evento: %s ' + LineBreak +
                             'Status do evento: %s ' + LineBreak +
                             'Descri��o do status: %s ' + LineBreak +
                             'Protocolo: %s ' + LineBreak +
                             'Data/Hora do registro: %s '),
                     [IntToStr(InfEvento.nSeqEvento),
                      TpEventoToStr(InfEvento.TpEvento),
                      InfEvento.DescEvento,
                      IntToStr(retEvento.Items[J].RetInfEvento.cStat),
                      retEvento.Items[J].RetInfEvento.xMotivo,
                      retEvento.Items[J].RetInfEvento.nProt,
                      FormatDateTimeBr(retEvento.Items[J].RetInfEvento.dhRegEvento)]);

            if retEvento.Items[J].RetInfEvento.tpEvento = teCancelamento then
            begin
              MDFCancelado := True;
              FProtocolo := retEvento.Items[J].RetInfEvento.nProt;
              FDhRecbto := retEvento.Items[J].RetInfEvento.dhRegEvento;
              FPMsg := retEvento.Items[J].RetInfEvento.xMotivo;
            end;
          end;
        end;
      end;
    end;

    if not MDFCancelado then
    begin
      FProtocolo := MDFeRetorno.protMDFe.nProt;
      FDhRecbto := MDFeRetorno.protMDFe.dhRecbto;
      FPMsg := MDFeRetorno.protMDFe.xMotivo;
    end;

    Result := (MDFeRetorno.CStat in [100, 101, 110, 150, 151, 155]);

    for i := 0 to TACBrMDFe(FPDFeOwner).Manifestos.Count - 1 do
    begin
      with TACBrMDFe(FPDFeOwner).Manifestos.Items[i] do
      begin
        if (OnlyNumber(FMDFeChave) = NumID) then
        begin
          Atualiza := True;
          if (MDFeRetorno.CStat in [101, 151, 155]) then
            Atualiza := False;

          // Atualiza o Status da MDFe interna //
          MDFe.procMDFe.cStat := MDFeRetorno.cStat;

          if Atualiza then
          begin
            if (FPConfiguracoesMDFe.Geral.ValidarDigest) and
              (MDFeRetorno.protMDFe.digVal <> '') and (MDFe.signature.DigestValue <> '') and
              (UpperCase(MDFe.signature.DigestValue) <> UpperCase(MDFeRetorno.protMDFe.digVal)) then
            begin
              raise EACBrMDFeException.Create('DigestValue do documento ' +
                NumID + ' n�o confere.');
            end;

            MDFe.procMDFe.tpAmb := MDFeRetorno.tpAmb;
            MDFe.procMDFe.verAplic := MDFeRetorno.verAplic;
            MDFe.procMDFe.chMDFe := MDFeRetorno.chMDFe;
            MDFe.procMDFe.dhRecbto := FDhRecbto;
            MDFe.procMDFe.nProt := FProtocolo;
            MDFe.procMDFe.digVal := MDFeRetorno.protMDFe.digVal;
            MDFe.procMDFe.cStat := MDFeRetorno.cStat;
            MDFe.procMDFe.xMotivo := MDFeRetorno.xMotivo;

            AProcMDFe := TProcMDFe.Create;
            try
              AProcMDFe.XML_MDFe := StringReplace(XMLAssinado,
                                         '<' + ENCODING_UTF8 + '>', '',
                                         [rfReplaceAll]);
              AProcMDFe.XML_Prot := MDFeRetorno.XMLprotMDFe;
              AProcMDFe.Versao := FPVersaoServico;
              AProcMDFe.GerarXML;

              XMLOriginal := AProcMDFe.Gerador.ArquivoFormatoXML;

              FRetMDFeDFe := '';

              if (NaoEstaVazio(SeparaDados(FPRetWS, 'procEventoMDFe'))) then
              begin
                Inicio := Pos('<procEventoMDFe', FPRetWS);
                Fim    := Pos('</retConsSitMDFe', FPRetWS) -1;

                aEventos := Copy(FPRetWS, Inicio, Fim - Inicio + 1);

                FRetMDFeDFe := // '<' + ENCODING_UTF8 + '>' +
                               '<MDFeDFe>' +
                                '<procMDFe versao="' + FVersao + '">' +
                                  SeparaDados(XMLOriginal, 'mdfeProc') +
                                '</procMDFe>' +
                                '<procEventoMDFe versao="' + FVersao + '">' +
                                  aEventos +
                                '</procEventoMDFe>' +
                               '</MDFeDFe>';

              end;
            finally
              AProcMDFe.Free;
            end;

            if FPConfiguracoesMDFe.Arquivos.Salvar then
            begin
              if FPConfiguracoesMDFe.Arquivos.EmissaoPathMDFe then
                Data := MDFe.Ide.dhEmi
              else
                Data := Now;

              SalvarXML := (not FPConfiguracoesMDFe.Arquivos.SalvarApenasMDFeProcessados) or
                           Processado;

              // Salva o XML do MDF-e assinado e protocolado
              if SalvarXML then
                FPDFeOwner.Gravar(FMDFeChave + '-mdfe.xml',
                                  XMLOriginal,
                                  PathWithDelim(FPConfiguracoesMDFe.Arquivos.GetPathMDFe(Data)));

              // Salva o XML do MDF-e assinado, protocolado e com os eventos
              if SalvarXML  and (FRetMDFeDFe <> '') then
                FPDFeOwner.Gravar(FMDFeChave + '-MDFeDFe.xml',
                                  FRetMDFeDFe,
                                  PathWithDelim(FPConfiguracoesMDFe.Arquivos.GetPathMDFe(Data)));

            end;
          end;

          break;
        end;
      end;
    end;
  finally
    MDFeRetorno.Free;
  end;
end;

function TMDFeConsulta.GerarMsgLog: String;
begin
  Result := Format(ACBrStr('Vers�o Layout: %s ' + LineBreak +
                           'Identificador: %s ' + LineBreak +
                           'Ambiente: %s ' + LineBreak +
                           'Vers�o Aplicativo: %s ' + LineBreak +
                           'Status C�digo: %s ' + LineBreak +
                           'Status Descri��o: %s ' + LineBreak +
                           'UF: %s ' + LineBreak +
                           'Chave Acesso: %s ' + LineBreak +
                           'Recebimento: %s ' + LineBreak +
                           'Protocolo: %s ' + LineBreak +
                           'Digest Value: %s ' + LineBreak),
                   [Fversao, FMDFeChave, TpAmbToStr(FTpAmb), FverAplic,
                    IntToStr(FcStat), FXMotivo, CodigoParaUF(FcUF), FMDFeChave,
                    FormatDateTimeBr(FDhRecbto), FProtocolo, FprotMDFe.digVal]);
end;

function TMDFeConsulta.GerarPrefixoArquivo: String;
begin
  Result := Trim(FMDFeChave);
end;

{ TMDFeEnvEvento }

constructor TMDFeEnvEvento.Create(AOwner: TACBrDFe; AEvento: TEventoMDFe);
begin
  inherited Create(AOwner);

  FEvento := AEvento;
end;

destructor TMDFeEnvEvento.Destroy;
begin
  FEventoRetorno.Free;

  inherited;
end;

procedure TMDFeEnvEvento.Clear;
begin
  inherited Clear;

  FPStatus := stMDFeEvento;
  FPLayout := LayMDFeEvento;
  FPArqEnv := 'ped-eve';
  FPArqResp := 'eve';

  FcStat   := 0;
  FxMotivo := '';
  FCNPJ := '';

  if Assigned(FPConfiguracoesMDFe) then
    FtpAmb := FPConfiguracoesMDFe.WebServices.Ambiente;

  if Assigned(FEventoRetorno) then
    FEventoRetorno.Free;

  FEventoRetorno := TRetEventoMDFe.Create;
end;

function TMDFeEnvEvento.GerarPathEvento(const ACNPJ: String): String;
begin
  with FEvento.Evento.Items[0].InfEvento do
  begin
    Result := FPConfiguracoesMDFe.Arquivos.GetPathEvento(tpEvento, ACNPJ);
  end;
end;

procedure TMDFeEnvEvento.DefinirURL;
var
  UF, Modelo : String;
  VerServ: Double;
begin
  { Verifica��o necess�ria pois somente os eventos de Cancelamento e CCe ser�o tratados pela SEFAZ do estado
    os outros eventos como manifestacao de destinat�rios ser�o tratados diretamente pela RFB }

  VerServ := VersaoMDFeToDbl(FPConfiguracoesMDFe.Geral.VersaoDF);
  FCNPJ   := FEvento.Evento.Items[0].InfEvento.CNPJ;
  FTpAmb  := FEvento.Evento.Items[0].InfEvento.tpAmb;
  Modelo  := 'MDFe';
  UF      := CUFtoUF(ExtrairUFChaveAcesso(FEvento.Evento.Items[0].InfEvento.chMDFe));

  FPLayout := LayMDFeEvento;

  FPURL := '';

  TACBrMDFe(FPDFeOwner).LerServicoDeParams(
    Modelo,
    UF,
    FTpAmb,
    LayOutToServico(FPLayout),
    VerServ,
    FPURL
  );

  FPVersaoServico := FloatToString(VerServ, '.', '0.00');
end;

procedure TMDFeEnvEvento.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'MDFeRecepcaoEvento';
  FPSoapAction := FPServico + '/mdfeRecepcaoEvento';
end;

procedure TMDFeEnvEvento.DefinirDadosMsg;
var
  EventoMDFe: TEventoMDFe;
  I, F: Integer;
  Evento, Eventos, EventosAssinados, AXMLEvento: String;
  EventoEhValido: Boolean;
  SchemaEventoMDFe: TSchemaMDFe;
begin
  EventoMDFe := TEventoMDFe.Create;
  try
    EventoMDFe.idLote := FidLote;

    for I := 0 to TMDFeEnvEvento(Self).FEvento.Evento.Count - 1 do
    begin
      with EventoMDFe.Evento.Add do
      begin
        infEvento.tpAmb      := FTpAmb;
        infEvento.CNPJ       := FEvento.Evento[i].InfEvento.CNPJ;
        infEvento.chMDFe     := FEvento.Evento[i].InfEvento.chMDFe;
        infEvento.dhEvento   := FEvento.Evento[i].InfEvento.dhEvento;
        infEvento.tpEvento   := FEvento.Evento[i].InfEvento.tpEvento;
        infEvento.nSeqEvento := FEvento.Evento[i].InfEvento.nSeqEvento;

        case InfEvento.tpEvento of
          teCancelamento:
          begin
            SchemaEventoMDFe := schevCancMDFe;
            infEvento.detEvento.nProt := FEvento.Evento[i].InfEvento.detEvento.nProt;
            infEvento.detEvento.xJust := FEvento.Evento[i].InfEvento.detEvento.xJust;
          end;
          teEncerramento:
          begin
            SchemaEventoMDFe := schevEncMDFe;
            infEvento.detEvento.nProt := FEvento.Evento[i].InfEvento.detEvento.nProt;
            infEvento.detEvento.dtEnc := FEvento.Evento[i].InfEvento.detEvento.dtEnc;
            infEvento.detEvento.cUF   := FEvento.Evento[i].InfEvento.detEvento.cUF;
            infEvento.detEvento.cMun  := FEvento.Evento[i].InfEvento.detEvento.cMun;
          end;
          teInclusaoCondutor:
          begin
            SchemaEventoMDFe := schevIncCondutorMDFe;
            infEvento.detEvento.xNome := FEvento.Evento[i].InfEvento.detEvento.xNome;
            infEvento.detEvento.CPF   := FEvento.Evento[i].InfEvento.detEvento.CPF;
          end;
        end;
      end;
    end;

    EventoMDFe.Versao := FPVersaoServico;
    EventoMDFe.GerarXML;

    Eventos := EventoMDFe.Gerador.ArquivoFormatoXML;
    EventosAssinados := '';

    // Realiza a assinatura para cada evento
    while Eventos <> '' do
    begin
      F := Pos('</eventoMDFe>', Eventos);

      if F > 0 then
      begin
        Evento := Copy(Eventos, 1, F + 12);
        Eventos := Copy(Eventos, F + 13, length(Eventos));

        AssinarXML(Evento, 'eventoMDFe', 'infEvento', 'Falha ao assinar o Envio de Evento ');

        EventosAssinados := EventosAssinados + StringReplace(
          FPDadosMsg, '<?xml version="1.0"?>', '', []);
      end
      else
        Break;
    end;

    // Separa o XML especifico do Evento para ser Validado.
    AXMLEvento := '<' + ENCODING_UTF8 + '>' +
                  SeparaDados(FPDadosMsg, 'detEvento');

    with TACBrMDFe(FPDFeOwner) do
    begin
      EventoEhValido := SSL.Validar(FPDadosMsg,
                                    GerarNomeArqSchema(FPLayout,
                                                       StringToFloatDef(FPVersaoServico, 0)),
                                    FPMsg) and
                        SSL.Validar(AXMLEvento,
                                    GerarNomeArqSchemaEvento(SchemaEventoMDFe,
                                                             StringToFloatDef(FPVersaoServico, 0)),
                                    FPMsg);
    end;

    for I := 0 to FEvento.Evento.Count - 1 do
      FEvento.Evento[I].InfEvento.id := EventoMDFe.Evento[I].InfEvento.id;
  finally
    EventoMDFe.Free;
  end;
end;

function TMDFeEnvEvento.TratarResposta: Boolean;
var
  Leitor: TLeitor;
  I, J: Integer;
  NomeArq, PathArq, VersaoEvento, Texto: String;
begin
  FEvento.idLote := idLote;

  FPRetWS := SeparaDados(FPRetornoWS, 'mdfeRecepcaoEventoResult');

  EventoRetorno.Leitor.Arquivo := FPRetWS;
  EventoRetorno.LerXml;

  FcStat := EventoRetorno.cStat;
  FxMotivo := EventoRetorno.xMotivo;
  FPMsg := EventoRetorno.xMotivo;
  FTpAmb := EventoRetorno.tpAmb;

  Result := (FcStat in [128, 135, 136, 155]);

  //gerar arquivo proc de evento
  if Result then
  begin
    Leitor := TLeitor.Create;
    try
      for I := 0 to FEvento.Evento.Count - 1 do
      begin
        for J := 0 to EventoRetorno.retEvento.Count - 1 do
        begin
          if FEvento.Evento.Items[I].InfEvento.chMDFe =
            EventoRetorno.retEvento.Items[J].RetInfEvento.chMDFe then
          begin
            FEvento.Evento.Items[I].RetInfEvento.tpAmb :=
              EventoRetorno.retEvento.Items[J].RetInfEvento.tpAmb;
            FEvento.Evento.Items[I].RetInfEvento.nProt :=
              EventoRetorno.retEvento.Items[J].RetInfEvento.nProt;
            FEvento.Evento.Items[I].RetInfEvento.dhRegEvento :=
              EventoRetorno.retEvento.Items[J].RetInfEvento.dhRegEvento;
            FEvento.Evento.Items[I].RetInfEvento.cStat :=
              EventoRetorno.retEvento.Items[J].RetInfEvento.cStat;
            FEvento.Evento.Items[I].RetInfEvento.xMotivo :=
              EventoRetorno.retEvento.Items[J].RetInfEvento.xMotivo;

            VersaoEvento := TACBrMDFe(FPDFeOwner).LerVersaoDeParams(LayMDFeEvento);


            Leitor.Arquivo := FPDadosMsg;
            Texto := // '<' + ENCODING_UTF8 + '>' +
                     '<procEventoMDFe versao="' + VersaoEvento + '" xmlns="' + ACBRMDFE_NAMESPACE + '">' +
                      '<eventoMDFe versao="' + VersaoEvento + '">' +
                       Leitor.rExtrai(1, 'infEvento', '', I + 1) +
                       '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">' +
                        Leitor.rExtrai(1, 'SignedInfo', '', I + 1) +
                        Leitor.rExtrai(1, 'SignatureValue', '', I + 1) +
                        Leitor.rExtrai(1, 'KeyInfo', '', I + 1) +
                       '</Signature>' +
                      '</eventoMDFe>';

            Leitor.Arquivo := FPRetWS;
            Texto := Texto +
                       '<retEventoMDFe versao="' + VersaoEvento + '">' +
                        Leitor.rExtrai(1, 'infEvento', '', J + 1) +
                       '</retEventoMDFe>' +
                      '</procEventoMDFe>';

            EventoRetorno.retEvento.Items[J].RetInfEvento.XML := Texto;

            FEvento.Evento.Items[I].RetInfEvento.XML := Texto;

            if FPConfiguracoesMDFe.Arquivos.Salvar then
            begin
              NomeArq := OnlyNumber(FEvento.Evento.Items[I].InfEvento.Id) + '-procEventoMDFe.xml';
              PathArq := PathWithDelim(GerarPathEvento(FEvento.Evento.Items[I].InfEvento.CNPJ));

              FPDFeOwner.Gravar(NomeArq, Texto, PathArq);
              FEvento.Evento.Items[I].RetInfEvento.NomeArquivo := PathArq + NomeArq;
            end;

            break;
          end;
        end;
      end;
    finally
      Leitor.Free;
    end;
  end;
end;

procedure TMDFeEnvEvento.SalvarEnvio;
begin
  inherited SalvarEnvio;

  if FPConfiguracoesMDFe.Geral.Salvar then
    FPDFeOwner.Gravar(GerarPrefixoArquivo + '-' + ArqEnv + '.xml',
      FPDadosMsg, GerarPathEvento(FCNPJ));
end;

procedure TMDFeEnvEvento.SalvarResposta;
begin
  inherited SalvarResposta;

  if FPConfiguracoesMDFe.Geral.Salvar then
    FPDFeOwner.Gravar(GerarPrefixoArquivo + '-' + ArqResp + '.xml',
      FPRetWS, GerarPathEvento(FCNPJ));
end;

function TMDFeEnvEvento.GerarMsgLog: String;
var
  aMsg: String;
begin
  aMsg := Format(ACBrStr('Vers�o Layout: %s ' + LineBreak +
                         'Ambiente: %s ' + LineBreak +
                         'Vers�o Aplicativo: %s ' + LineBreak +
                         'Status C�digo: %s ' + LineBreak +
                         'Status Descri��o: %s ' + LineBreak),
                 [FEventoRetorno.versao, TpAmbToStr(FEventoRetorno.tpAmb),
                  FEventoRetorno.verAplic, IntToStr(FEventoRetorno.cStat),
                  FEventoRetorno.xMotivo]);

  if FEventoRetorno.retEvento.Count > 0 then
    aMsg := aMsg + Format(ACBrStr('Recebimento: %s ' + LineBreak),
       [IfThen(FEventoRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento = 0, '',
               FormatDateTimeBr(FEventoRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento))]);

  Result := aMsg;
end;

function TMDFeEnvEvento.GerarPrefixoArquivo: String;
begin
  Result := IntToStr(FEvento.idLote);
end;

{ TMDFeConsultaMDFeNaoEnc }

constructor TMDFeConsultaMDFeNaoEnc.Create(AOwner: TACBrDFe);
begin
  inherited Create(AOwner);

  FOwner := AOwner;
end;

destructor TMDFeConsultaMDFeNaoEnc.Destroy;
begin
  FinfMDFe.Free;

  inherited;
end;

procedure TMDFeConsultaMDFeNaoEnc.Clear;
begin
  inherited Clear;

  FPStatus  := stMDFeConsulta;
  FPLayout  := LayMDFeConsNaoEnc;
  FPArqEnv  := 'ped-cons';
  FPArqResp := 'cons';

  if Assigned(FPConfiguracoesMDFe) then
  begin
    FtpAmb := FPConfiguracoesMDFe.WebServices.Ambiente;
    FcUF := FPConfiguracoesMDFe.WebServices.UFCodigo;
  end;

  if Assigned(FinfMDFe) then
    FinfMDFe.Free;

  if Assigned(FRetConsMDFeNaoEnc) then
    FRetConsMDFeNaoEnc.Free;

  FInfMDFe := TRetInfMDFeCollection.Create(FOwner);
  FRetConsMDFeNaoEnc := TRetConsMDFeNaoEnc.Create;
end;

procedure TMDFeConsultaMDFeNaoEnc.DefinirServicoEAction;
begin
  FPServico    := GetUrlWsd + 'MDFeConsNaoEnc';
  FPSoapAction := FPServico + '/mdfeConsNaoEnc';
end;

procedure TMDFeConsultaMDFeNaoEnc.DefinirURL;
begin
  FPLayout := LayMDFeConsNaoEnc;

  inherited DefinirURL;
end;

procedure TMDFeConsultaMDFeNaoEnc.DefinirDadosMsg;
var
  ConsMDFeNaoEnc: TConsMDFeNaoEnc;
begin
  ConsMDFeNaoEnc := TConsMDFeNaoEnc.create;
  try
    ConsMDFeNaoEnc.TpAmb := FPConfiguracoesMDFe.WebServices.Ambiente;
    ConsMDFeNaoEnc.CNPJ  := FCNPJ; // TMDFeConsultaMDFeNaoEnc(Self).CNPJ;

    ConsMDFeNaoEnc.Gerador.Opcoes.RetirarAcentos := FPConfiguracoesMDFe.Geral.RetirarAcentos;
    ConsMDFeNaoEnc.Versao := FPVersaoServico;
    ConsMDFeNaoEnc.GerarXML;

    FPDadosMsg := ConsMDFeNaoEnc.Gerador.ArquivoFormatoXML;
  finally
    ConsMDFeNaoEnc.Free;
  end;
end;

function TMDFeConsultaMDFeNaoEnc.TratarResposta: Boolean;
var
  i: Integer;
begin
  FPRetWS := SeparaDados(FPRetornoWS, 'mdfeConsNaoEncResult');

  // Limpando variaveis internas
  FRetConsMDFeNaoEnc.Free;
  FRetConsMDFeNaoEnc := TRetConsMDFeNaoEnc.Create;

  FRetConsMDFeNaoEnc.Leitor.Arquivo := FPRetWS;
  FRetConsMDFeNaoEnc.LerXml;

  Fversao    := FRetConsMDFeNaoEnc.versao;
  FtpAmb     := FRetConsMDFeNaoEnc.tpAmb;
  FverAplic  := FRetConsMDFeNaoEnc.verAplic;
  FcStat     := FRetConsMDFeNaoEnc.cStat;
  FxMotivo   := FRetConsMDFeNaoEnc.xMotivo;
  FcUF       := FRetConsMDFeNaoEnc.cUF;
  FMsg       := FxMotivo;

  for i := 0 to FRetConsMDFeNaoEnc.InfMDFe.Count -1 do
  begin
    FinfMDFe.Add;
    FinfMDFe.Items[i].chMDFe := FRetConsMDFeNaoEnc.InfMDFe.Items[i].chMDFe;
    FinfMDFe.Items[i].nProt  := FRetConsMDFeNaoEnc.InfMDFe.Items[i].nProt;
  end;

    // 111 = MDF-e n�o encerrados localizados
    // 112 = MDF-e n�o encerrados n�o localizados
  Result := (FcStat in [111, 112]);
end;

function TMDFeConsultaMDFeNaoEnc.GerarMsgLog: String;
begin
  Result := Format(ACBrStr('Vers�o Layout: %s ' + LineBreak +
                           'Ambiente: %s ' + LineBreak +
                           'Vers�o Aplicativo: %s ' + LineBreak +
                           'Status C�digo: %s ' + LineBreak +
                           'Status Descri��o: %s ' + LineBreak +
                           'UF: %s ' + LineBreak),
                   [FRetConsMDFeNaoEnc.versao, TpAmbToStr(FRetConsMDFeNaoEnc.tpAmb),
                    FRetConsMDFeNaoEnc.verAplic, IntToStr(FRetConsMDFeNaoEnc.cStat),
                    FRetConsMDFeNaoEnc.xMotivo,
                    CodigoParaUF(FRetConsMDFeNaoEnc.cUF)]);
end;

function TMDFeConsultaMDFeNaoEnc.GerarMsgErro(E: Exception): String;
begin
  Result := ACBrStr('WebService Consulta MDF-e nao Encerradas:' + LineBreak +
                    '- Inativo ou Inoperante tente novamente.');
end;

{ TDistribuicaoDFe }

constructor TDistribuicaoDFe.Create(AOwner: TACBrDFe);
begin
  inherited Create(AOwner);
end;

destructor TDistribuicaoDFe.Destroy;
begin
  FretDistDFeInt.Free;

  inherited;
end;

procedure TDistribuicaoDFe.Clear;
begin
  inherited Clear;

  FPStatus := stMDFeDistDFeInt;
  FPLayout := LayMDFeDistDFeInt;
  FPArqEnv := 'con-dist-dfe';
  FPArqResp := 'dist-dfe';
//  FPBodyElement := 'mdfeDistDFeInteresse';
//  FPHeaderElement := '';

  if Assigned(FretDistDFeInt) then
    FretDistDFeInt.Free;

  FretDistDFeInt := TRetDistDFeInt.Create;
end;

procedure TDistribuicaoDFe.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'MDFeDistribuicaoDFe';
  FPSoapAction := FPServico + '/mdfeDistDFeInteresse';
end;

procedure TDistribuicaoDFe.DefinirDadosMsg;
var
  DistDFeInt: TDistDFeInt;
begin
  DistDFeInt := TDistDFeInt.Create;
  try
    DistDFeInt.TpAmb := FPConfiguracoesMDFe.WebServices.Ambiente;
//    DistDFeInt.cUFAutor := FcUFAutor;
    DistDFeInt.CNPJCPF := FCNPJCPF;
    DistDFeInt.ultNSU := FultNSU;
    DistDFeInt.NSU := FNSU;
    DistDFeInt.Versao := FPVersaoServico;
    DistDFeInt.GerarXML;

    FPDadosMsg := DistDFeInt.Gerador.ArquivoFormatoXML;
  finally
    DistDFeInt.Free;
  end;
end;

function TDistribuicaoDFe.TratarResposta: Boolean;
var
  I: Integer;
  AXML, NomeArq: String;
begin
  FPRetWS := SeparaDados(FPRetornoWS, 'mdfeDistDFeInteresseResult');

  FretDistDFeInt.Leitor.Arquivo := FPRetWS;
  FretDistDFeInt.LerXml;

  FPMsg := FretDistDFeInt.xMotivo;
  Result := (FretDistDFeInt.CStat = 137) or (FretDistDFeInt.CStat = 138);

  for I := 0 to FretDistDFeInt.docZip.Count - 1 do
  begin
    AXML := FretDistDFeInt.docZip.Items[I].XML;
    NomeArq := '';
    if (AXML <> '') then
    begin
      case FretDistDFeInt.docZip.Items[I].schema of
        (*
        schresMDFe:
          NomeArq := FretDistDFeInt.docZip.Items[I].resMDFe.chMDFe + '-resMDFe.xml';
        schresEvento:
          NomeArq := OnlyNumber(TpEventoToStr(FretDistDFeInt.docZip.Items[I].resEvento.tpEvento) +
             FretDistDFeInt.docZip.Items[I].resEvento.chMDFe +
             Format('%.2d', [FretDistDFeInt.docZip.Items[I].resEvento.nSeqEvento])) +
             '-resEventoMDFe.xml';
        *)
        schprocMDFe:
          NomeArq := FretDistDFeInt.docZip.Items[I].resMDFe.chMDFe + '-mdfe.xml';
        schprocEventoMDFe:
          NomeArq := OnlyNumber(FretDistDFeInt.docZip.Items[I].procEvento.Id) +
            '-procEventoMDFe.xml';
      end;

      if (FPConfiguracoesMDFe.Arquivos.Salvar) and NaoEstaVazio(NomeArq) then
        FPDFeOwner.Gravar(NomeArq, AXML, GerarPathDistribuicao(FretDistDFeInt.docZip.Items[I]));
    end;
  end;
end;

function TDistribuicaoDFe.GerarMsgLog: String;
begin
  Result := Format(ACBrStr('Vers�o Layout: %s ' + LineBreak +
                           'Ambiente: %s ' + LineBreak +
                           'Vers�o Aplicativo: %s ' + LineBreak +
                           'Status C�digo: %s ' + LineBreak +
                           'Status Descri��o: %s ' + LineBreak +
                           'Resposta: %s ' + LineBreak +
                           '�ltimo NSU: %s ' + LineBreak +
                           'M�ximo NSU: %s ' + LineBreak),
                   [FretDistDFeInt.versao, TpAmbToStr(FretDistDFeInt.tpAmb),
                    FretDistDFeInt.verAplic, IntToStr(FretDistDFeInt.cStat),
                    FretDistDFeInt.xMotivo,
                    IfThen(FretDistDFeInt.dhResp = 0, '',
                           FormatDateTimeBr(RetDistDFeInt.dhResp)),
                    FretDistDFeInt.ultNSU, FretDistDFeInt.maxNSU]);
end;

function TDistribuicaoDFe.GerarMsgErro(E: Exception): String;
begin
  Result := ACBrStr('WebService Distribui��o de DFe:' + LineBreak +
                    '- Inativo ou Inoperante tente novamente.');
end;

function TDistribuicaoDFe.GerarPathDistribuicao(
  AItem: TdocZipCollectionItem): String;
var
  Data: TDateTime;
begin
  if FPConfiguracoesMDFe.Arquivos.EmissaoPathMDFe then
    Data := AItem.resMDFe.dhEmi
  else
    Data := Now;

  Result := FPConfiguracoesMDFe.Arquivos.GetPathDownload(AItem.resMDFe.xNome,
                                                         AItem.resMDFe.CNPJCPF,
                                                         Data);
end;
(*
procedure TDistribuicaoDFe.DefinirURL;
var
  UF, Modelo: String;
  Versao: Double;
begin
  { Esse m�todo � tratado diretamente pela RFB }

  UF := 'AN';
  Modelo := 'MDFe';
  Versao := 0;
  FPVersaoServico := '';
  FPURL := '';
  Versao := VersaoMDFeToDbl(FPConfiguracoesMDFe.Geral.VersaoDF);

  TACBrMDFe(FPDFeOwner).LerServicoDeParams(
    Modelo,
    UF ,
    FPConfiguracoesMDFe.WebServices.Ambiente,
    LayOutToServico(FPLayout),
    Versao,
    FPURL);

  FPVersaoServico := FloatToString(Versao, '.', '0.00');
end;
*)
{ TMDFeEnvioWebService }

constructor TMDFeEnvioWebService.Create(AOwner: TACBrDFe);
begin
  inherited Create(AOwner);

  FPStatus := stMDFeEnvioWebService;
end;

destructor TMDFeEnvioWebService.Destroy;
begin
  inherited Destroy;
end;

procedure TMDFeEnvioWebService.Clear;
begin
  inherited Clear;

  FVersao := '';
end;

function TMDFeEnvioWebService.Executar: Boolean;
begin
  Result := inherited Executar;
end;

procedure TMDFeEnvioWebService.DefinirURL;
begin
  FPURL := FPURLEnvio;
end;

procedure TMDFeEnvioWebService.DefinirServicoEAction;
begin
  FPServico := FPSoapAction;
end;

procedure TMDFeEnvioWebService.DefinirDadosMsg;
var
  LeitorXML: TLeitor;
begin
  LeitorXML := TLeitor.Create;
  try
    LeitorXML.Arquivo := FXMLEnvio;
    LeitorXML.Grupo := FXMLEnvio;
    FVersao := LeitorXML.rAtributo('versao')
  finally
    LeitorXML.Free;
  end;

  FPDadosMsg := FXMLEnvio;
end;

function TMDFeEnvioWebService.TratarResposta: Boolean;
begin
  FPRetWS := SeparaDados(FPRetornoWS, 'soap:Body');
  Result := True;
end;

function TMDFeEnvioWebService.GerarMsgErro(E: Exception): String;
begin
  Result := ACBrStr('WebService: '+FPServico + LineBreak +
                    '- Inativo ou Inoperante tente novamente.');
end;

function TMDFeEnvioWebService.GerarVersaoDadosSoap: String;
begin
  Result := '<versaoDados>' + FVersao + '</versaoDados>';
end;

{ TWebServices }

constructor TWebServices.Create(AOwner: TACBrDFe);
begin
  FACBrMDFe := TACBrMDFe(AOwner);

  FStatusServico := TMDFeStatusServico.Create(FACBrMDFe);
  FEnviar := TMDFeRecepcao.Create(FACBrMDFe, TACBrMDFe(FACBrMDFe).Manifestos);
  FRetorno := TMDFeRetRecepcao.Create(FACBrMDFe, TACBrMDFe(FACBrMDFe).Manifestos);
  FRecibo := TMDFeRecibo.Create(FACBrMDFe, TACBrMDFe(FACBrMDFe).Manifestos);
  FConsulta := TMDFeConsulta.Create(FACBrMDFe, TACBrMDFe(FACBrMDFe).Manifestos);
  FEnvEvento := TMDFeEnvEvento.Create(FACBrMDFe, TACBrMDFe(FACBrMDFe).EventoMDFe);
  FConsMDFeNaoEnc := TMDFeConsultaMDFeNaoEnc.Create(FACBrMDFe);
  FDistribuicaoDFe := TDistribuicaoDFe.Create(FACBrMDFe);
  FEnvioWebService := TMDFeEnvioWebService.Create(FACBrMDFe);
end;

destructor TWebServices.Destroy;
begin
  FStatusServico.Free;
  FEnviar.Free;
  FRetorno.Free;
  FRecibo.Free;
  FConsulta.Free;
  FEnvEvento.Free;
  FConsMDFeNaoEnc.Free;
  FDistribuicaoDFe.Free;
  FEnvioWebService.Free;

  inherited Destroy;
end;

function TWebServices.Envia(ALote: Integer): Boolean;
begin
  Result := Envia(IntToStr(ALote));
end;

function TWebServices.Envia(ALote: String): Boolean;
begin
  FEnviar.Lote := ALote;

  if not Enviar.Executar then
    Enviar.GerarException( Enviar.Msg );

  FRetorno.Recibo := FEnviar.Recibo;
  if not FRetorno.Executar then
    FRetorno.GerarException( FRetorno.Msg );

  Result := True;
end;

function TWebServices.ConsultaMDFeNaoEnc(ACNPJ: String): Boolean;
begin
  FConsMDFeNaoEnc.FCNPJ := ACNPJ;

  if not FConsMDFeNaoEnc.Executar then
    FConsMDFeNaoEnc.GerarException( FConsMDFeNaoEnc.Msg );

  Result := True;
end;

end.
