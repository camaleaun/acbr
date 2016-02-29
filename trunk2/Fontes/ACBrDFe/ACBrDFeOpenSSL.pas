{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emiss�o de Nota Fiscal}
{ eletr�nica - NFe - http://www.nfe.fazenda.gov.br                             }

{ Direitos Autorais Reservados (c) 2015 Daniel Simoes de Almeida               }
{                                       Andr� Ferreira de Moraes               }

{ Colaboradores nesse arquivo:                                                 }

{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }


{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }

{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }

{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }

{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }

{******************************************************************************}

{$I ACBr.inc}

unit ACBrDFeOpenSSL;

interface

uses
  Classes, SysUtils,
  ACBrDFeSSL,
  HTTPSend, ssl_openssl,
  libxmlsec, libxslt, libxml2,
  {$IFDEF USE_libeay32}libeay32{$ELSE} OpenSSLExt{$ENDIF}  ;

const
  cDTD = '<!DOCTYPE test [<!ATTLIST &infElement& Id ID #IMPLIED>]>';

  cErrMngrCreate = 'Erro: Falha ao criar Gerenciador de Chaves "xmlSecKeysMngrCreate"';
  cErrMngrInit = 'Erro: Falha ao inicializar o Gerenciador de Chaves "xmlSecCryptoAppDefaultKeysMngrInit"';
  cErrCertLoad = 'Erro: Falha ao ler informa��o do Certificado no Gerenciador de Chaves';
  cErrParseDoc = 'Erro: Falha ao interpretar o XML "xmlParseDoc"';
  cErrFindSignNode = 'Erro: Falha ao localizar o n� de Assinatura';
  cErrFindRootNode = 'Erro: Falha ao localizar o n� Raiz';
  cErrCtxCreate = 'Erro: Falha ao criar Ctx "xmlSecDSigCtxCreate"';
  cErrPrivKeyLoad = 'Erro: Falha ao ler a Chave Privada de DadosPFX';
  cErrPubKeyLoad = 'Erro: Falha ao ler a Chave Publica do Certificado';
  cErrDSigSign = 'Erro: Falha ao assinar o Documento';
  cErrDSigVerify = 'Erro: Falha na verifica��o da Assinatura';


type
  { TDFeOpenSSL }

  TDFeOpenSSL = class(TDFeSSLClass)
  private                     FHTTP: THTTPSend;
    FdsigCtx: xmlSecDSigCtxPtr;
    FCNPJ: String;
    FRazaoSocial: String;
    FKey: pEVP_PKEY;
    FNumSerie: String;
    FValidade: TDateTime;
    FSubjectName: String;

    procedure Clear;
    procedure ConfiguraHTTP(const URL, SoapAction: String; MimeType: String);
    function InserirDTD(AXml: String; const DTD: String): String;
    function LerPFXInfo(pfxdata: Ansistring): Boolean;

    procedure VerificarValoresPadrao(var SignatureNode: AnsiString;
      var SelectionNamespaces: AnsiString);
    function XmlSecSign(const ConteudoXML: AnsiString;
      SignatureNode, SelectionNamespaces: AnsiString): AnsiString;
    procedure CreateCtx;
    procedure DestroyCtx;
    procedure DestroyKey;
  protected

    function GetCertDataVenc: TDateTime; override;
    function GetCertNumeroSerie: String; override;
    function GetCertSubjectName: String; override;
    function GetCertRazaoSocial: String; override;
    function GetCertCNPJ: String; override;
    function GetHTTPResultCode: Integer; override;
    function GetInternalErrorCode: Integer; override;

  public
    constructor Create(ADFeSSL: TDFeSSL); override;
    destructor Destroy; override;

    function Assinar(const ConteudoXML, docElement, infElement: String;
      SignatureNode: String = ''; SelectionNamespaces: String = '';
      IdSignature: String = ''): String; override;
    function Enviar(const ConteudoXML: String; const URL: String;
      const SoapAction: String; const MimeType: String = ''): String; override;
    function Validar(const ConteudoXML, ArqSchema: String;
      out MsgErro: String): Boolean; override;
    function VerificarAssinatura(const ConteudoXML: String; out MsgErro: String;
      const infElement: String; SignatureNode: String = '';
      SelectionNamespaces: String = ''): Boolean; override;

    function CalcHash( const AStream : TStream;
       const Digest: TSSLDgst;
       const Assinar: Boolean =  False): AnsiString; override;

    procedure CarregarCertificado; override;
    procedure DescarregarCertificado; override;
  end;

procedure InitXmlSec;
procedure ShutDownXmlSec;

var
  XMLSecLoaded: boolean;

implementation

uses Math, strutils, dateutils,
  ACBrUtil, ACBrDFeException, ACBrDFeUtil, ACBrConsts,
  pcnAuxiliar,
  synautil, synacode;

procedure InitXmlSec;
begin
  if XMLSecLoaded then exit;

  { Init libxml and libxslt libraries }
  xmlInitThreads();
  xmlInitParser();
  __xmlLoadExtDtdDefaultValue^ := XML_DETECT_IDS or XML_COMPLETE_ATTRS;
  xmlSubstituteEntitiesDefault(1);
  __xmlIndentTreeOutput^ := 1;

  { Init xmlsec library }
  if (xmlSecInit() < 0) then
    raise EACBrDFeException.Create('Error: xmlsec initialization failed.');

  { Check loaded library version }
  if (xmlSecCheckVersionExt(1, 2, 18, xmlSecCheckVersionABICompatible) <> 1) then
    raise EACBrDFeException.Create(
      'Error: loaded xmlsec library version is not compatible.');

  (* Load default crypto engine if we are supporting dynamic
   * loading for xmlsec-crypto libraries. Use the crypto library
   * name ("openssl", "nss", etc.) to load corresponding
   * xmlsec-crypto library.
   *)
  if (xmlSecCryptoDLLoadLibrary('openssl') < 0) then
    raise EACBrDFeException.Create(
      'Error: unable to load default xmlsec-crypto library. Make sure'#10 +
      'that you have it installed and check shared libraries path'#10 +
      '(LD_LIBRARY_PATH) environment variable.');

  { Init crypto library }
  if (xmlSecCryptoAppInit(nil) < 0) then
    raise EACBrDFeException.Create('Error: crypto initialization failed.');

  { Init xmlsec-crypto library }
  if (xmlSecCryptoInit() < 0) then
    raise EACBrDFeException.Create('Error: xmlsec-crypto initialization failed.');

  XMLSecLoaded := True;
end;

procedure ShutDownXmlSec;
begin
  { Shutdown xmlsec-crypto library }
  xmlSecCryptoShutdown();

  { Shutdown crypto library }
  xmlSecCryptoAppShutdown();

  { Shutdown xmlsec library }
  xmlSecShutdown();

  { Shutdown libxslt/libxml }
  xsltCleanupGlobals();
  xmlCleanupParser();

  XMLSecLoaded := False;
end;


{ TDFeOpenSSL }

constructor TDFeOpenSSL.Create(ADFeSSL: TDFeSSL);
begin
  inherited Create(ADFeSSL);

  FHTTP := THTTPSend.Create;
  FdsigCtx := nil;
  Clear;
end;

destructor TDFeOpenSSL.Destroy;
begin
  DescarregarCertificado;
  FHTTP.Free;

  inherited Destroy;
end;

function TDFeOpenSSL.Assinar(const ConteudoXML, docElement, infElement: String;
  SignatureNode: String; SelectionNamespaces: String; IdSignature: String
  ): String;
var
  AXml, XmlAss, DTD: String;
begin
  // Nota: "ConteudoXML" j� deve estar convertido para UTF8 //
  XmlAss := '';
  DTD := StringReplace(cDTD, '&infElement&', infElement, []);
  AXml := InserirDTD(ConteudoXML, DTD);

  // Inserindo Template da Assinatura digital //
  if (not XmlEstaAssinado(AXml)) or (SignatureNode <> '') then
    AXml := AdicionarSignatureElement(AXml, True, docElement, IdSignature);

  // Assinando com XMLSec //
  //DEBUG
  //WriteToTXT('C:\TEMP\XmlToSign.xml', AXml, False, False);

  XmlAss := XmlSecSign(AXml, AnsiString(SignatureNode), AnsiString(SelectionNamespaces));
  XmlAss := AjustarXMLAssinado(XmlAss);

  // Removendo DTD //
  Result := StringReplace(XmlAss, DTD, '', []);
end;

function TDFeOpenSSL.Enviar(const ConteudoXML: String; const URL: String;
  const SoapAction: String; const MimeType: String): String;
var
  OK: Boolean;
  RetornoWS: AnsiString;
begin
  RetornoWS := '';

  // Configurando o THTTPSend //
  ConfiguraHTTP(URL, 'SOAPAction: "' + SoapAction + '"', MimeType);

  // Gravando no Buffer de Envio //
  WriteStrToStream(FHTTP.Document, AnsiString(ConteudoXML)) ;

  // DEBUG //
  //FHTTP.Document.SaveToFile( 'c:\temp\HttpSendDocument.xml' );
  //FHTTP.Headers.SaveToFile( 'c:\temp\HttpSendHeader.xml' );

  // Transmitindo //
  OK := FHTTP.HTTPMethod('POST', URL);
  OK := OK and (FHTTP.ResultCode = 200);
  if not OK then
    raise EACBrDFeException.CreateFmt( cACBrDFeSSLEnviarException,
                                       [InternalErrorCode, HTTPResultCode] );

  // Lendo a resposta //
  FHTTP.Document.Position := 0;
  RetornoWS := ReadStrFromStream(FHTTP.Document, FHTTP.Document.Size);

  // DEBUG //
  //HTTP.Document.SaveToFile('c:\temp\ReqResp.xml');

  Result := String( RetornoWS );
end;

function TDFeOpenSSL.Validar(const ConteudoXML, ArqSchema: String;
  out MsgErro: String): Boolean;
var
  doc, schema_doc: xmlDocPtr;
  parser_ctxt: xmlSchemaParserCtxtPtr;
  schema: xmlSchemaPtr;
  valid_ctxt: xmlSchemaValidCtxtPtr;
  schemError: xmlErrorPtr;
  AXml: AnsiString;
begin
  InitXmlSec;

  Result := False;
  doc := Nil;
  schema_doc := Nil;
  parser_ctxt := Nil;
  schema := Nil;
  valid_ctxt := Nil;

  try
    AXml := ACBrStrToUTF8(ConteudoXML);
    doc := xmlParseDoc(PAnsiChar(AXml));
    if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
    begin
      MsgErro := 'Erro: unable to parse';
      exit;
    end;

    schema_doc := xmlReadFile(PAnsiChar(AnsiString(ArqSchema)), nil, XML_DETECT_IDS);
    // the schema cannot be loaded or is not well-formed
    if (schema_doc = nil) then
    begin
      MsgErro := 'Erro: Schema n�o pode ser carregado ou est� corrompido';
      exit;
    end;

    parser_ctxt := xmlSchemaNewDocParserCtxt(schema_doc);
    // unable to create a parser context for the schema */
    if (parser_ctxt = nil) then
    begin
      MsgErro := 'Erro: unable to create a parser context for the schema';
      exit;
    end;

    schema := xmlSchemaParse(parser_ctxt);
    // the schema itself is not valid
    if (schema = nil) then
    begin
      MsgErro := 'Error: the schema itself is not valid';
      exit;
    end;

    valid_ctxt := xmlSchemaNewValidCtxt(schema);
    // unable to create a validation context for the schema */
    if (valid_ctxt = nil) then
    begin
      MsgErro := 'Error: unable to create a validation context for the schema';
      exit;
    end;

    if (xmlSchemaValidateDoc(valid_ctxt, doc) <> 0) then
    begin
      schemError := xmlGetLastError();
      if (schemError <> nil) then
        MsgErro := IntToStr(schemError^.code) + ' - ' + schemError^.message;
    end
    else
      Result := True;

  finally
    { cleanup }
    if (doc <> nil) then
      xmlFreeDoc(doc);

    if (schema_doc <> nil) then
      xmlFreeDoc(schema_doc);

    if (parser_ctxt <> nil) then
      xmlSchemaFreeParserCtxt(parser_ctxt);

    if (valid_ctxt <> nil) then
      xmlSchemaFreeValidCtxt(valid_ctxt);

    if (schema <> nil) then
      xmlSchemaFree(schema);
  end;
end;

function TDFeOpenSSL.VerificarAssinatura(const ConteudoXML: String; out
  MsgErro: String; const infElement: String; SignatureNode: String;
  SelectionNamespaces: String): Boolean;
var
  doc: xmlDocPtr;
  node: xmlNodePtr;
  dsigCtx: xmlSecDSigCtxPtr;
  mngr: xmlSecKeysMngrPtr;
  X509Certificate, DTD: String;
  AXml, SigNode, SelName: AnsiString;
  MS: TMemoryStream;

const
  xmlSecKeyDataTypeTrusted = $0100 ;

begin
  InitXmlSec;

  SigNode := AnsiString(SignatureNode);
  SelName := AnsiString(SelectionNamespaces);
  VerificarValoresPadrao(SigNode, SelName);

  Result := False;
  X509Certificate := copy(ConteudoXML, pos('<X509Certificate>', ConteudoXML) + 17,
                  pos('</X509Certificate>', ConteudoXML) -
                  (pos('<X509Certificate>', ConteudoXML) + 17));

  DTD  := StringReplace(cDTD, '&infElement&', infElement, []);
  AXml := ACBrStrToUTF8(InserirDTD(ConteudoXML, DTD));

  doc := nil;
  node := nil;
  dsigCtx := nil;
  mngr := nil;

  MS := TMemoryStream.Create;
  try
    WriteStrToStream(MS, DecodeBase64(X509Certificate) );
    //DEBUG
    //MS.Position := 0;
    //MS.SaveToFile('c:\temp\cert.der');

    mngr := xmlSecKeysMngrCreate();
    if (mngr = nil) then
    begin
      MsgErro := cErrMngrCreate;
      exit;
    end;

    if xmlSecCryptoAppDefaultKeysMngrInit(mngr) < 0 then
    begin
      MsgErro := cErrMngrInit;
      exit;
    end;

    { Load the Certificate }
    MS.Position := 0;
    if (xmlSecCryptoAppKeysMngrCertLoadMemory(mngr, MS.Memory, MS.Size,
      xmlSecKeyDataFormatCertDer, xmlSecKeyDataTypeTrusted) < 0) then
    begin
      MsgErro := cErrCertLoad;
      exit;
    end;

    doc := xmlParseDoc(PAnsiChar(AXml));
    if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
    begin
      MsgErro := cErrParseDoc;
      exit;
    end;

    node := xmlSecFindChild(xmlDocGetRootElement(doc),
               xmlCharPtr(SigNode), xmlCharPtr(SelName) );
    if (node = nil) then
    begin
      MsgErro := cErrFindSignNode;
      exit;
    end;

    dsigCtx := xmlSecDSigCtxCreate(mngr);
    if (dsigCtx = nil) then
    begin
      MsgErro := cErrCtxCreate;
      exit;
    end;

    MS.Position := 0;
    dsigCtx^.signKey := xmlSecCryptoAppKeyLoadMemory(MS.Memory, MS.Size,
      xmlSecKeyDataFormatCertDer, nil, nil, nil);
    if (dsigCtx^.signKey = nil) then
    begin
      MsgErro := cErrPubKeyLoad;
      exit;
    end;

    { Verify signature }
    if (xmlSecDSigCtxVerify(dsigCtx, node) < 0) then
    begin
      MsgErro := cErrDSigVerify;
      exit;
    end;

    Result := (dsigCtx.status = xmlSecDSigStatusSucceeded);
  finally
    { cleanup }
    MS.Free;

    if (doc <> nil) then
      xmlFreeDoc(doc);

    if (dsigCtx <> nil) then
      xmlSecDSigCtxDestroy(dsigCtx);
  end;
end;

{ M�todo clonado de ACBrEAD }
function TDFeOpenSSL.CalcHash(const AStream: TStream; const Digest: TSSLDgst;
  const Assinar: Boolean): AnsiString;
Var
  md : PEVP_MD ;
  md_len: cardinal;
  md_ctx: EVP_MD_CTX;
  md_value_bin : array [0..1023] of AnsiChar;
  NameDgst : PAnsiChar;
  ABinStr: AnsiString;
  Memory: Pointer;
  PosStream: Int64;
  BytesRead: LongInt;
begin
  NameDgst := '';
  case Digest of
    dgstMD2    : NameDgst := 'md2';
    dgstMD4    : NameDgst := 'md4';
    dgstMD5    : NameDgst := 'md5';
    dgstRMD160 : NameDgst := 'rmd160';
    dgstSHA    : NameDgst := 'sha';
    dgstSHA1   : NameDgst := 'sha1';
    dgstSHA256 : NameDgst := 'sha256';
    dgstSHA512 : NameDgst := 'sha512';
  end ;

  if Assinar and (FKey = Nil) then
    CarregarCertificado;

  PosStream := 0;
  AStream.Position := 0;
  GetMem(Memory, CBufferSize);
  try
    md_len := 0;
    md := EVP_get_digestbyname( NameDgst );
    EVP_DigestInit( @md_ctx, md );

    while (PosStream < AStream.Size) do
    begin
       BytesRead := AStream.Read(Memory^, CBufferSize);
       if BytesRead <= 0 then
          Break;

       EVP_DigestUpdate( @md_ctx, Memory, BytesRead ) ;
       PosStream := PosStream + BytesRead;
    end;

    if Assinar then
       EVP_SignFinal( @md_ctx, @md_value_bin, md_len, FKey)
    else
       EVP_DigestFinal( @md_ctx, @md_value_bin, {$IFNDEF USE_libeay32}@{$ENDIF}md_len);

    SetString( ABinStr, md_value_bin, md_len);
    Result := ABinStr;
  finally
    Freemem(Memory);
  end;
end;

function TDFeOpenSSL.XmlSecSign(const ConteudoXML: AnsiString; SignatureNode,
  SelectionNamespaces: AnsiString): AnsiString;
var
  doc: xmlDocPtr;
  node, RootElement: xmlNodePtr;
  buffer: PAnsiChar;
  bufSize: integer;
begin
  InitXmlSec;

  doc := Nil;
  Result := '';

  if Trim(ConteudoXML) = '' then
    Exit;

  CreateCtx;
  try
    VerificarValoresPadrao(SignatureNode, SelectionNamespaces);

    { load template }
    doc := xmlParseDoc(PAnsiChar(ConteudoXML));
    if (doc = nil) then
      raise EACBrDFeException.Create(cErrParseDoc);

    { find start node }
    RootElement := xmlDocGetRootElement(doc);
    if (RootElement = nil) then
      raise EACBrDFeException.Create(cErrFindRootNode);

    { find Signature node }
    node := xmlSecFindChild(RootElement,
               xmlCharPtr(SignatureNode), xmlCharPtr(SelectionNamespaces) );
    if (node = nil) then
      raise EACBrDFeException.Create(cErrFindSignNode);

    { sign the template }
    if (xmlSecDSigCtxSign(FdsigCtx, node) < 0) then
      raise EACBrDFeException.Create(cErrDSigSign);

    { print signed document to stdout }
    // xmlDocDump(stdout, doc);
    // Can't use "stdout" from Delphi, so we'll use xmlDocDumpMemory instead...
    buffer := nil;
    xmlDocDumpMemory(doc, @buffer, @bufSize);
    if (buffer <> nil) then
      { success }
      Result := buffer;
  finally
    { cleanup }
    if (doc <> nil) then
      xmlFreeDoc(doc);

    DestroyCtx ;
  end;
end;

procedure TDFeOpenSSL.CreateCtx;
var
  MS: TMemoryStream;
begin
  InitXmlSec;
  // Se FdsigCtx j� existia, destrua e crie um novo //
  DestroyCtx;

  with FpDFeSSL do
  begin
    if EstaVazio(DadosPFX) then
      Self.CarregarCertificado;

    { create signature context }
    FdsigCtx := xmlSecDSigCtxCreate(nil);
    if (FdsigCtx = nil) then
      raise EACBrDFeException.Create(cErrCtxCreate);

    MS := TMemoryStream.Create;
    try
      WriteStrToStream(MS, DadosPFX);

      MS.Position := 0;
      FdsigCtx^.signKey := xmlSecCryptoAppKeyLoadMemory(
        MS.Memory, MS.Size, xmlSecKeyDataFormatPkcs12,
        PAnsiChar(Senha), nil, nil);

      if (FdsigCtx^.signKey = nil) then
        raise EACBrDFeException.Create(cErrPrivKeyLoad);
    finally
      MS.Free;
    end;
  end;
end;

procedure TDFeOpenSSL.DestroyCtx;
begin
  if (FdsigCtx <> nil) then
  begin
    InitXmlSec;
    xmlSecDSigCtxDestroy(FdsigCtx);
    FdsigCtx := nil;
  end;
end;

procedure TDFeOpenSSL.DestroyKey;
begin
  if FKey <> Nil then
  begin
    {$IFDEF USE_libeay32}
     EVP_PKEY_free(FKey);
    {$ELSE}
     EvpPkeyFree(FKey);
    {$ENDIF}
    FKey := nil;
  end;
end;

procedure TDFeOpenSSL.CarregarCertificado;
var
  LoadFromFile, LoadFromData: Boolean;
  FS: TFileStream;
begin
  with FpDFeSSL do
  begin
    // Verificando se possui par�metros necess�rios //
    if EstaVazio(ArquivoPFX) and EstaVazio(DadosPFX) then
    begin
      if not EstaVazio(NumeroSerie) then
        raise EACBrDFeException.Create(ClassName +
          ' n�o suporta carga de Certificado pelo n�mero de s�rie.' +
          sLineBreak + 'Utilize "ArquivoPFX" ou "DadosPFX"')
      else
        raise EACBrDFeException.Create('Certificado n�o informado.' +
          sLineBreak + 'Utilize "ArquivoPFX" ou "DadosPFX"');
    end;

    LoadFromFile := (not EstaVazio(ArquivoPFX)) and FileExists(ArquivoPFX);
    LoadFromData := (not EstaVazio(DadosPFX));

    if not (LoadFromFile or LoadFromData) then
      raise EACBrDFeException.Create('Arquivo: ' + ArquivoPFX + ' n�o encontrado, e DadosPFX n�o informado');

    if LoadFromFile then
    begin
      FS := TFileStream.Create(ArquivoPFX, fmOpenRead or fmShareDenyNone);
      try
        DadosPFX := ReadStrFromStream(FS, FS.Size);
      finally
        FS.Free;
      end;
    end;

    if EstaVazio(DadosPFX) then
      raise EACBrDFeException.Create('Erro ao Carregar Certificado');

    FHTTP.Sock.SSL.PFX := DadosPFX;
    FHTTP.Sock.SSL.KeyPassword := Senha;

    if not LerPFXInfo(DadosPFX) then
      raise EACBrDFeException.Create('Erro ao ler informa��es do Certificado.'+sLineBreak+
                                     'Provavelmente a senha est� errada' );
  end;

  FpCertificadoLido := True;
end;

procedure TDFeOpenSSL.DescarregarCertificado;
begin
  DestroyCtx;
  DestroyKey;
  Clear;
  FpCertificadoLido := False;
end;

function TDFeOpenSSL.LerPFXInfo(pfxdata: Ansistring): Boolean;

  function GetNotAfter( cert: pX509 ): TDateTime;
  var
    Validade: String;
    notAfter: PASN1_TIME;
  begin
    notAfter := cert.cert_info^.validity^.notAfter;
    Validade := StrPas( PAnsiChar(notAfter^.data) );
    SetLength(Validade, notAfter^.length);
    Validade := OnlyNumber(Validade);

    if notAfter^.asn1_type = V_ASN1_UTCTIME then  // anos com 2 d�gitos
      Validade :=  LeftStr(IntToStrZero(YearOf(Now),4),2) + Validade;

    Result := StoD(Validade);
  end;

  function GetSubjectName( cert: pX509 ): String;
  var
    s: String;
  begin
    setlength(s, 4096);
    {$IFDEF USE_libeay32}
     Result := X509_NAME_oneline(X509_get_subject_name(cert), PAnsiChar(s), Length(s));
    {$ELSE}
     Result := X509NameOneline(X509GetSubjectName(cert), s, Length(s));
    {$ENDIF}
    if copy(Result,1,1) = '/' then
      Result := Copy(Result,2,Length(Result));

    Result := StringReplace(Result, '/', ', ', [rfReplaceAll]);
  end;

  function GetCNPJExt( cert: pX509): String;
  var
    ext: pX509_EXTENSION;
    I, P: Integer;
    prop: PASN1_STRING;
    propStr: AnsiString;
  begin
    Result := '';
    I := 0;
   {$IFDEF USE_libeay32}
    ext := X509_get_ext( cert, I);
   {$ELSE}
    ext := X509GetExt( cert, I);
   {$ENDIF}
    while (ext <> nil) do
    begin
      prop := ext.value;
      propStr := PAnsiChar(prop^.data);
      SetLength(propStr, prop^.length);

      P := pos(#1#3#3#160#16, propStr);;
      if P > 0 then
      begin
        Result := LeftStr(OnlyNumber(copy(propStr,P+5,16)),14);
        exit;
      end;

      inc( I );
      {$IFDEF USE_libeay32}
       ext := X509_get_ext( cert, I);
      {$ELSE}
       ext := X509GetExt( cert, I);
      {$ENDIF}
    end;
  end;

  function GetSerialNumber( cert: pX509): String;
  var
    SN: PASN1_STRING;
    s: AnsiString;
  begin
    {$IFDEF USE_libeay32}
     SN := X509_get_serialNumber(cert);
    {$ELSE}
     SN := X509GetSerialNumber(cert);
    {$ENDIF}
    s := StrPas( PAnsiChar(SN^.data) );
    SetLength(s,SN.length);
    Result := AsciiToHex(s);
  end;

var
  cert: pX509;
  ca, p12: Pointer;
  b: PBIO;
begin
  Result := False;
  DestroyKey;

  {$IFDEF USE_libeay32}
   b := Bio_New(BIO_s_mem);
  {$ELSE}
   b := BioNew(BioSMem);
  {$ENDIF}
  try
    {$IFDEF USE_libeay32}
     BIO_write(b, PAnsiChar(pfxdata), Length(PfxData));
     p12 := d2i_PKCS12_bio(b, nil);
    {$ELSE}
     BioWrite(b, pfxdata, Length(PfxData));
     p12 := d2iPKCS12bio(b, nil);
    {$ENDIF}
    if not Assigned(p12) then
      Exit;

    try
      cert := nil;
      FKey := nil;
      ca   := nil;
      try
        {$IFDEF USE_libeay32}
        if PKCS12_parse(p12, PAnsiChar(FpDFeSSL.Senha), FKey, cert, ca) > 0 then
        {$ELSE}
        if PKCS12parse(p12, FpDFeSSL.Senha, FKey, cert, ca) > 0 then
        {$ENDIF}
        begin
          Result := True;
          FValidade := GetNotAfter( cert );
          FSubjectName := GetSubjectName( cert );
          FRazaoSocial := GetRazaoSocialFromSubjectName( FSubjectName );
          FCNPJ := GetCNPJFromSubjectName( FSubjectName );
          if FCNPJ = '' then  // N�o tem CNPJ no SubjectName, lendo das Extens�es
            FCNPJ := GetCNPJExt( cert );

          FNumSerie := GetSerialNumber( cert );
        end;
      finally
        {$IFDEF USE_libeay32}
         X509_free(cert);
        {$ELSE}
         X509free(cert);
        {$ENDIF}
      end;
    finally
      {$IFDEF USE_libeay32}
       PKCS12_free(p12);
      {$ELSE}
       PKCS12free(p12);
      {$ENDIF}
    end;
  finally
    {$IFDEF USE_libeay32}
     BIO_free_all(b);
    {$ELSE}
     BioFreeAll(b);
    {$ENDIF}
  end;
end;

procedure TDFeOpenSSL.VerificarValoresPadrao(var SignatureNode: AnsiString;
  var SelectionNamespaces: AnsiString);
var
  DSigNs: String;
begin
  {
    N�o est� funcionando adequadamente, pois n�o estamos fazendo uso dos
    par�metros enviados. Entretanto atualmente OpenSSL consegue assinar XMLs
    com 2 assinaturas, mesmo sem essa informa��o, pois o comando
    "xmlSecFindChild" consegue achar o N� de assinatura, imeditamente inferior
    ao elemento raiz selecionado
  }

  //if SignatureNode = '' then
    SignatureNode := xmlSecNodeSignature();
  //else
  //  SignatureNode := copy(SignatureNode, Pos(':',SignatureNode)+1, Length(SignatureNode));

  DSigNs := xmlSecDSigNs();

  //if SelectionNamespaces = '' then
    SelectionNamespaces := DSigNs
  //else
  //begin
  //  SelectionNamespaces := RetornarConteudoEntre( SelectionNamespaces, '"', '"');
  //
  //  if LeftStr(SelectionNamespaces, Length(DSigNs)) <> DSigNs then
  //    SelectionNamespaces := DSigNs + ' ' + SelectionNamespaces;
  //end;
end;


function TDFeOpenSSL.GetCertDataVenc: TDateTime;
begin
  if FValidade = 0 then
    CarregarCertificado;

  Result := FValidade;
end;

function TDFeOpenSSL.GetCertNumeroSerie: String;
begin
  if EstaVazio(FNumSerie) then
    CarregarCertificado;

  Result := FNumSerie;
end;

function TDFeOpenSSL.GetCertSubjectName: String;
begin
  if EstaVazio(FSubjectName) then
    CarregarCertificado;

  Result := FSubjectName;
end;

function TDFeOpenSSL.GetCertRazaoSocial: String;
begin
  if EstaVazio(FRazaoSocial) then
    CarregarCertificado;

  Result := FRazaoSocial;
end;

function TDFeOpenSSL.GetCertCNPJ: String;
begin
  if EstaVazio(FCNPJ) then
    CarregarCertificado;

  Result := FCNPJ;
end;

function TDFeOpenSSL.GetHTTPResultCode: Integer;
begin
  Result := FHTTP.ResultCode;
end;

function TDFeOpenSSL.GetInternalErrorCode: Integer;
begin
  Result := FHTTP.Sock.LastError;
end;

procedure TDFeOpenSSL.Clear;
begin
  FCNPJ := '';
  FRazaoSocial := '';
  FNumSerie := '';
  FValidade := 0;
  FSubjectName := '';
  FHTTP.Sock.SSL.PFX := '';
  FHTTP.Sock.SSL.KeyPassword := '';
end;

procedure TDFeOpenSSL.ConfiguraHTTP(const URL, SoapAction: String;
  MimeType: String);
begin
  FHTTP.Clear;

  if FHTTP.Sock.SSL.PFX = '' then
    CarregarCertificado;

  FHTTP.Timeout   := FpDFeSSL.TimeOut;
  FHTTP.ProxyHost := FpDFeSSL.ProxyHost;
  FHTTP.ProxyPort := FpDFeSSL.ProxyPort;
  FHTTP.ProxyUser := FpDFeSSL.ProxyUser;
  FHTTP.ProxyPass := FpDFeSSL.ProxyPass;

  if MimeType = '' then
    MimeType := 'application/soap+xml';

  FHTTP.MimeType := MimeType + '; charset=utf-8';     // Todos DFes usam UTF8

  FHTTP.UserAgent := '';
  FHTTP.Protocol := '1.1';
  FHTTP.AddPortNumberToHost := False;
  FHTTP.Headers.Add(SoapAction);
end;

function TDFeOpenSSL.InserirDTD(AXml: String; const DTD: String): String;
var
  I: integer;
begin
  // Adicionando Cabe�alho DTD, necess�rio para xmlsec encontrar o ID //
  I := pos('?>', AXml);
  Result := Copy(AXml, 1, IfThen(I > 0, I + 1, I)) +
            DTD +
            Copy(AXml, IfThen(I > 0, I + 2, I), Length(AXml));
end;

initialization
  XMLSecLoaded := False;

finalization;
  ShutDownXmlSec;

end.
