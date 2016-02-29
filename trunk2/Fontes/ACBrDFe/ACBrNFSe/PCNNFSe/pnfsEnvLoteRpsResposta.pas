{******************************************************************************}
{ Projeto: Componente ACBrNFSe                                                 }
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

{$I ACBr.inc}

unit pnfsEnvLoteRpsResposta;

interface

uses
  SysUtils, Classes,
  pcnAuxiliar, pcnConversao, pcnLeitor, pnfsConversao, pnfsNFSe;

type

  TMsgRetornoEnvCollection     = class;
  TMsgRetornoEnvCollectionItem = class;
  TInfRec = class;

 TChaveNFeRPSCollectionItem = class(TCollectionItem)
  private
    FChaveNFeRPS: TChaveNFeRPS;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property ChaveNFeRPS: TChaveNFeRPS read FChaveNFeRPS write FChaveNFeRPS;
  end;

 TChaveNFeRPSCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TChaveNFeRPSCollectionItem;
    procedure SetItem(Index: Integer; Value: TChaveNFeRPSCollectionItem);
  public
    constructor Create(AOwner: TInfRec);
    function Add: TChaveNFeRPSCollectionItem;
    property Items[Index: Integer]: TChaveNFeRPSCollectionItem read GetItem write SetItem; default;
  end;

  TInfRec = class
  private
    FNumeroLote: String;
    FDataRecebimento: TDateTime;
    FProtocolo: String;
    FSucesso: String;
    FMsgRetorno: TMsgRetornoEnvCollection;
    FInformacoesLote: TInformacoesLote;
    FListaChaveNFeRPS: TChaveNFeRPSCollection;

    procedure SetMsgRetorno(Value: TMsgRetornoEnvCollection);
    procedure SetListaChaveNFeRPS(const Value: TChaveNFeRPSCollection);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    property NumeroLote: String                   read FNumeroLote      write FNumeroLote;
    property DataRecebimento: TDateTime           read FDataRecebimento write FDataRecebimento;
    property Protocolo: String                    read FProtocolo       write FProtocolo;
    property Sucesso: String                      read FSucesso         write FSucesso;
    property MsgRetorno: TMsgRetornoEnvCollection read FMsgRetorno      write SetMsgRetorno;
    property InformacoesLote: TInformacoesLote    read FInformacoesLote write FInformacoesLote;
    property ListaChaveNFeRPS: TChaveNFeRPSCollection  read FListaChaveNFeRPS     write SetListaChaveNFeRPS;
  end;

 TMsgRetornoEnvCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TMsgRetornoEnvCollectionItem;
    procedure SetItem(Index: Integer; Value: TMsgRetornoEnvCollectionItem);
  public
    constructor Create(AOwner: TInfRec);
    function Add: TMsgRetornoEnvCollectionItem;
    property Items[Index: Integer]: TMsgRetornoEnvCollectionItem read GetItem write SetItem; default;
  end;

 TMsgRetornoEnvCollectionItem = class(TCollectionItem)
  private
    FCodigo: String;
    FMensagem: String;
    FCorrecao: String;
    FIdentificacaoRps: TMsgRetornoIdentificacaoRps;
    FChaveNFeRPS: TChaveNFeRPS;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Codigo: String   read FCodigo   write FCodigo;
    property Mensagem: String read FMensagem write FMensagem;
    property Correcao: String read FCorrecao write FCorrecao;
    property IdentificacaoRps: TMsgRetornoIdentificacaoRps  read FIdentificacaoRps write FIdentificacaoRps;
    property ChaveNFeRPS: TChaveNFeRPS read FChaveNFeRPS write FChaveNFeRPS;
  end;

  TretEnvLote = class(TPersistent)
  private
    FLeitor: TLeitor;
    FInfRec: TInfRec;
    FProvedor: TnfseProvedor;
  public
    constructor Create;
    destructor Destroy; override;

    function LerXml: Boolean;

    function LerXml_ABRASF: Boolean;

    function LerXml_proCONAM: Boolean;
    function LerXml_proEquiplano: Boolean;
    function LerXml_proEL: Boolean;
    function LerXml_proGoverna: Boolean;
    function LerXml_proInfisc: Boolean;
    function LerXml_proISSDSF: Boolean;
	  function LerXml_proNFSeBrasil: Boolean;
    function LerXml_proSP: Boolean;

  published
    property Leitor: TLeitor         read FLeitor   write FLeitor;
    property InfRec: TInfRec         read FInfRec   write FInfRec;
    property Provedor: TnfseProvedor read FProvedor write FProvedor;
  end;

implementation

{ TInfRec }

constructor TInfRec.Create;
begin
  FMsgRetorno := TMsgRetornoEnvCollection.Create(Self);
  FInformacoesLote := TInformacoesLote.Create;
  FListaChaveNFeRPS := TChaveNFeRPSCollection.Create(Self);
end;

destructor TInfRec.Destroy;
begin
  FMsgRetorno.Free;
  FInformacoesLote.Free;
  FListaChaveNFeRPS.Free;
  inherited;
end;

procedure TInfRec.SetListaChaveNFeRPS(const Value: TChaveNFeRPSCollection);
begin
  FListaChaveNFeRPS := Value;
end;

procedure TInfRec.SetMsgRetorno(Value: TMsgRetornoEnvCollection);
begin
  FMsgRetorno.Assign(Value);
end;

{ TMsgRetornoEnvCollection }

function TMsgRetornoEnvCollection.Add: TMsgRetornoEnvCollectionItem;
begin
  Result := TMsgRetornoEnvCollectionItem(inherited Add);
  Result.create;
end;

constructor TMsgRetornoEnvCollection.Create(AOwner: TInfRec);
begin
  inherited Create(TMsgRetornoEnvCollectionItem);
end;

function TMsgRetornoEnvCollection.GetItem(
  Index: Integer): TMsgRetornoEnvCollectionItem;
begin
  Result := TMsgRetornoEnvCollectionItem(inherited GetItem(Index));
end;

procedure TMsgRetornoEnvCollection.SetItem(Index: Integer;
  Value: TMsgRetornoEnvCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TMsgRetornoEnvCollectionItem }

constructor TMsgRetornoEnvCollectionItem.Create;
begin
  FIdentificacaoRps := TMsgRetornoIdentificacaoRps.Create;
  FIdentificacaoRps.Tipo := trRPS;
  FChaveNFeRPS := TChaveNFeRPS.Create;
end;

destructor TMsgRetornoEnvCollectionItem.Destroy;
begin
  FIdentificacaoRps.Free;
  FChaveNFeRPS.Free;
  inherited;
end;

{ TChaveNFeRPSCollection }

function TChaveNFeRPSCollection.Add: TChaveNFeRPSCollectionItem;
begin
  Result := TChaveNFeRPSCollectionItem(inherited Add);
  Result.create;
end;

constructor TChaveNFeRPSCollection.Create(AOwner: TInfRec);
begin
  inherited Create(TChaveNFeRPSCollectionItem);
end;

function TChaveNFeRPSCollection.GetItem(
  Index: Integer): TChaveNFeRPSCollectionItem;
begin
  Result := TChaveNFeRPSCollectionItem(inherited GetItem(Index));
end;

procedure TChaveNFeRPSCollection.SetItem(Index: Integer;
  Value: TChaveNFeRPSCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TChaveNFeRPSCollectionItem }

constructor TChaveNFeRPSCollectionItem.Create;
begin
  FChaveNFeRPS := TChaveNFeRPS.Create;
end;

destructor TChaveNFeRPSCollectionItem.Destroy;
begin
  FChaveNFeRPS.Free;
  inherited;
end;

{ TretEnvLote }

constructor TretEnvLote.Create;
begin
  FLeitor := TLeitor.Create;
  FInfRec := TInfRec.Create
end;

destructor TretEnvLote.Destroy;
begin
  FLeitor.Free;
  FinfRec.Free;
  inherited;
end;

function TretEnvLote.LerXml: Boolean;
begin
 case Provedor of
   proCONAM:      Result := LerXml_proCONAM;
   proEL:         Result := LerXml_proEL;
   proEquiplano:  Result := LerXml_proEquiplano;
   proGoverna:    Result := LerXml_proGoverna;
   proInfIsc:     Result := LerXml_proInfisc;
   proISSDSF:     Result := LerXml_proISSDSF;
   proNFSeBrasil: Result := LerXml_proNFSeBrasil;
   proSP:         Result := LerXml_proSP;
 else
   Result := LerXml_ABRASF;
 end;
end;

function TretEnvLote.LerXml_ABRASF: Boolean;
var
  i: Integer;
  iNivel: Integer;
  Ok: Boolean;
begin
  Result := True;

  try
    Leitor.Arquivo := RemoverNameSpace(RetirarPrefixos(Leitor.Arquivo));
    Leitor.Grupo   := Leitor.Arquivo;

    infRec.FNumeroLote := Leitor.rCampo(tcStr, 'NumeroLote');
    infRec.FProtocolo  := Leitor.rCampo(tcStr, 'Protocolo');

    // Alguns provedores retornam apenas a data, sem o hor�rio
    if Length(Leitor.rCampo(tcStr, 'DataRecebimento')) > 10
     then infRec.FDataRecebimento := Leitor.rCampo(tcDatHor, 'DataRecebimento')
     else infRec.FDataRecebimento := Leitor.rCampo(tcDat, 'DataRecebimento');

    iNivel := 1;
    if leitor.rExtrai(2, 'ListaMensagemRetorno') <> '' then
      iNivel := 3
    else
      if leitor.rExtrai(1, 'ListaMensagemRetorno') <> '' then
        iNivel := 2;

    i := 0;
    while Leitor.rExtrai(iNivel, 'MensagemRetorno', '', i + 1) <> '' do
    begin
      InfRec.FMsgRetorno.Add;
      InfRec.FMsgRetorno[i].FIdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'Numero');
      InfRec.FMsgRetorno[i].FIdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'Serie');
      InfRec.FMsgRetorno[i].FIdentificacaoRps.Tipo   := StrToTipoRPS(Ok, Leitor.rCampo(tcStr, 'Tipo'));

      InfRec.FMsgRetorno[i].FCodigo   := Leitor.rCampo(tcStr, 'Codigo');
      InfRec.FMsgRetorno[i].FMensagem := Leitor.rCampo(tcStr, 'Mensagem');
      InfRec.FMsgRetorno[i].FCorrecao := Leitor.rCampo(tcStr, 'Correcao');

      inc(i);
    end;

    i := 0;
    while Leitor.rExtrai(iNivel, 'ErroWebServiceResposta', '', i + 1) <> '' do
    begin
      InfRec.FMsgRetorno.Add;
      InfRec.FMsgRetorno[i].FCodigo   := Leitor.rCampo(tcStr, 'CodigoErro');
      InfRec.FMsgRetorno[i].FMensagem := Leitor.rCampo(tcStr, 'MensagemErro');
      InfRec.FMsgRetorno[i].FCorrecao := '';

      inc(i);
    end;

    i := 0;
    while (Leitor.rExtrai(1, 'Fault', '', i + 1) <> '') do
    begin
      InfRec.FMsgRetorno.Add;
      InfRec.FMsgRetorno[i].FCodigo   := Leitor.rCampo(tcStr, 'faultcode');
      InfRec.FMsgRetorno[i].FMensagem := Leitor.rCampo(tcStr, 'faultstring');
      InfRec.FMsgRetorno[i].FCorrecao := '';

      inc(i);
    end;

  except
    Result := False;
  end;
end;

function TretEnvLote.LerXml_proISSDSF: Boolean;
var
  i, posI, count: Integer;
  strAux: AnsiString;
  leitorAux: TLeitor;
begin
  Result := False;

  try
    Leitor.Arquivo := RetirarPrefixos(Leitor.Arquivo);
    Leitor.Grupo   := Leitor.Arquivo;

    if leitor.rExtrai(1, 'RetornoEnvioLoteRPS') <> '' then
    begin
      if (leitor.rExtrai(2, 'Cabecalho') <> '') then
      begin
        FInfRec.FSucesso := Leitor.rCampo(tcStr, 'Sucesso');
        if (FInfRec.FSucesso = 'true') then
        begin
          FInfRec.FNumeroLote      := Leitor.rCampo(tcStr, 'NumeroLote');
          FInfRec.FProtocolo       := Leitor.rCampo(tcStr, 'NumeroLote');
          FinfRec.FDataRecebimento := Leitor.rCampo(tcDatHor, 'DataEnvioLote')
        end;
      end;

      i := 0;
      if (leitor.rExtrai(1, 'Alertas') <> '') then
      begin
        strAux := leitor.rExtrai(1, 'Alertas');
        if (strAux <> '') then
        begin
          posI := pos('<Alerta>', strAux);

          while ( posI > 0 ) do
          begin
            count := pos('</Alerta>', strAux) + 7;

            FInfRec.FMsgRetorno.Add;

            LeitorAux := TLeitor.Create;
            leitorAux.Arquivo := copy(strAux, PosI, count);
            leitorAux.Grupo   := leitorAux.Arquivo;

            FInfRec.FMsgRetorno[i].FCodigo   := leitorAux.rCampo(tcStr, 'Codigo');
            FInfRec.FMsgRetorno[i].FMensagem := leitorAux.rCampo(tcStr, 'Descricao');
            FInfRec.FMsgRetorno[i].FCorrecao := '';

            inc(i);
            LeitorAux.free;

            Delete(strAux, PosI, count);
            posI := pos('<Alerta>', strAux);
          end;
        end;
      end;

      if (leitor.rExtrai(1, 'Erros') <> '') then
      begin
        strAux := leitor.rExtrai(1, 'Erros');
        if (strAux <> '') then
        begin
            //i := 0 ;
          posI := pos('<Erro>', strAux);

          while (posI > 0) do
          begin
            count := pos('</Erro>', strAux) + 6;

            FInfRec.FMsgRetorno.Add;

            LeitorAux := TLeitor.Create;
            leitorAux.Arquivo := copy(strAux, PosI, count);
            leitorAux.Grupo   := leitorAux.Arquivo;

            FInfRec.FMsgRetorno[i].FCodigo   := leitorAux.rCampo(tcStr, 'Codigo');
            FInfRec.FMsgRetorno[i].FMensagem := leitorAux.rCampo(tcStr, 'Descricao');
            FInfRec.FMsgRetorno[i].FCorrecao := '';

            inc(i);
            LeitorAux.free;

            Delete(strAux, PosI, count);
            posI := pos('<Erro>', strAux);
          end;
        end;
      end;

      Result := True;
    end;
  except
    Result := False;
  end;
end;

function TretEnvLote.LerXml_proEquiplano: Boolean;
var
  i: Integer;
begin
  try
    Leitor.Arquivo := RetirarPrefixos(Leitor.Arquivo);
    Leitor.Grupo   := Leitor.Arquivo;

    infRec.FNumeroLote      := Leitor.rCampo(tcStr, 'nrLote');
    infRec.FDataRecebimento := Leitor.rCampo(tcDatHor, 'dtRecebimento');
    infRec.FProtocolo       := Leitor.rCampo(tcStr, 'nrProtocolo');

    if leitor.rExtrai(1, 'mensagemRetorno') <> '' then
    begin
      i := 0;
      if (leitor.rExtrai(2, 'listaErros') <> '') then
      begin
        while Leitor.rExtrai(3, 'erro', '', i + 1) <> '' do
        begin
          InfRec.FMsgRetorno.Add;
          InfRec.FMsgRetorno[i].FCodigo  := Leitor.rCampo(tcStr, 'cdMensagem');
          InfRec.FMsgRetorno[i].FMensagem:= Leitor.rCampo(tcStr, 'dsMensagem');
          InfRec.FMsgRetorno[i].FCorrecao:= Leitor.rCampo(tcStr, 'dsCorrecao');

          inc(i);
        end;
      end;

      if (leitor.rExtrai(2, 'listaAlertas') <> '') then
      begin
        while Leitor.rExtrai(3, 'alerta', '', i + 1) <> '' do
        begin
          InfRec.FMsgRetorno.Add;
          InfRec.FMsgRetorno[i].FCodigo  := Leitor.rCampo(tcStr, 'cdMensagem');
          InfRec.FMsgRetorno[i].FMensagem:= Leitor.rCampo(tcStr, 'dsMensagem');
          InfRec.FMsgRetorno[i].FCorrecao:= Leitor.rCampo(tcStr, 'dsCorrecao');

          inc(i);
        end;
      end;
    end;

    Result := True;
  except
    Result := False;
  end;
end;

function TretEnvLote.LerXml_proInfisc: Boolean;
var
  sMotCod, sMotDes: String;
begin
  Result := False;
  try
    Leitor.Arquivo := RetirarPrefixos(Leitor.Arquivo);
    Leitor.Grupo   := Leitor.Arquivo;
    if leitor.rExtrai(1, 'confirmaLote') <> '' then
    begin
      FInfRec.FSucesso := Leitor.rCampo(tcStr, 'sit');
      if (FInfRec.FSucesso = '100') then // 100-Aceito
      begin
        FInfRec.FNumeroLote      := Leitor.rCampo(tcStr, 'cLote');
        FInfRec.FProtocolo       := Leitor.rCampo(tcStr, 'cLote');
        FinfRec.FDataRecebimento := Leitor.rCampo(tcDatHor, 'dhRecbto')
      end
      else if (FInfRec.FSucesso = '200') then // 200-Rejeitado
      begin
        sMotDes:=Leitor.rCampo(tcStr, 'mot');
        if Pos('Error', sMotDes) > 0 then
          sMotCod := SomenteNumeros(copy(sMotDes, 1, Pos(' ', sMotDes)))
        else
          sMotCod := '';
        InfRec.MsgRetorno.Add;
        InfRec.MsgRetorno[0].FCodigo   := sMotCod;
        InfRec.MsgRetorno[0].FMensagem := sMotDes + ' ' +
                                          'CNPJ ' + Leitor.rCampo(tcStr, 'CNPJ') + ' ' +
                                          'DATA ' + Leitor.rCampo(tcStr, 'dhRecbto');
        InfRec.MsgRetorno[0].FCorrecao := '';
      end;

      Result := True;
    end;
  except
    Result := False;
  end;
end;

function TretEnvLote.LerXml_proEL: Boolean;
var
  i: Integer;
  Cod, Msg: String;
  strAux: AnsiString;
begin
  try
    Leitor.Arquivo := RetirarPrefixos(Leitor.Arquivo);
    Leitor.Grupo   := Leitor.Arquivo;

    infRec.FNumeroLote      := Leitor.rCampo(tcStr, 'numeroLote');
    infRec.FDataRecebimento := Leitor.rCampo(tcDatHor, 'dataRecebimento');
    infRec.FProtocolo       := Leitor.rCampo(tcStr, 'numeroProtocolo');

    if (Leitor.rExtrai(1, 'mensagens') <> '') then
    begin
      i := 0;
      while Leitor.rExtrai(1, 'mensagens', '', i + 1) <> '' do
      begin
        strAux := Leitor.rCampo(tcStr, 'mensagens');
        Cod    := Copy(strAux, 1, 4);
        Msg    := Copy(strAux, 8, Length(strAux));
        if Trim(Msg) <> '' then
        begin
          InfRec.FMsgRetorno.Add;
          InfRec.FMsgRetorno[i].FCodigo   := Cod;
          InfRec.FMsgRetorno[i].FMensagem := Msg;
          InfRec.FMsgRetorno[i].FCorrecao := '';
          Inc(i);
        end
        else
          Break;
      end;
    end;

    Result := True;
  except
    Result := False;
  end;
end;

function TretEnvLote.LerXml_proNFSeBrasil: Boolean;
//var
  //Item, posI, count: Integer;
  //VersaoXML: String;
  //strAux,strAux2, strItem: AnsiString;
  //leitorAux, leitorItem:TLeitor;
begin
  result := False;
   // Luiz Bai�o 2014.12.01
  (*
  try
    Leitor.Arquivo := RetirarPrefixos(Leitor.Arquivo);
    VersaoXML      := '1';
    Leitor.Grupo   := Leitor.Arquivo;

    strAux := leitor.rExtrai_NFSEBrasil(1, 'RespostaLoteRps');

    if ( strAux <> emptystr) then  begin
           FInfRec.FSucesso := Leitor.rCampo(tcStr, 'Sucesso');
           if (FInfRec.FSucesso <> emptystr) then  begin
              FInfRec.FNumeroLote :=  Leitor.rCampo(tcStr, 'NumeroLote');
              FInfRec.Protocolo   :=  Leitor.rCampo(tcStr, 'Protocolo');
           end;

       infRec.FProtocolo := Leitor.rCampo(tcStr, 'Protocolo');
    end;

    strAux := leitor.rExtrai_NFSEBrasil(1, 'erros');
    if ( strAux <> emptystr) then begin

        posI := 1;
        i := 0 ;
        while ( posI > 0 ) do begin
             count := pos('</erro>', strAux) + 7;

             LeitorAux := TLeitor.Create;
             leitorAux.Arquivo := copy(strAux, PosI, count);
             leitorAux.Grupo   := leitorAux.Arquivo;
             strAux2 := leitorAux.rExtrai_NFSEBrasil(1,'erro');
             strAux2 := Leitor.rCampo(tcStr, 'erro');
             FInfRec.FMsgRetorno.Add;
             FInfRec.FMsgRetorno.Items[i].Mensagem := Leitor.rCampo(tcStr, 'erro')+#13;
             inc(i);
             LeitorAux.free;
             Delete(strAux, PosI, count);
             posI := pos('<erro>', strAux);
        end;
    end;

    strAux := leitor.rExtrai_NFSEBrasil(1, 'confirmacoes');
    if ( strAux <> emptystr) then begin

        posI := 1;
        // i := 0 ;
        while ( posI > 0 ) do begin

           count := pos('</confirmacao>', strAux) + 7;
           LeitorAux := TLeitor.Create;
           leitorAux.Arquivo := copy(strAux, PosI, count);
           leitorAux.Grupo   := leitorAux.Arquivo;
           strAux2 := leitorAux.rExtrai_NFSEBrasil(1,'confirmacao');
           strAux2 := Leitor.rCampo(tcStr, 'confirmacao');
           FInfRec.FMsgRetorno.Add;
           FInfRec.FMsgRetorno.Items[i].Mensagem := Leitor.rCampo(tcStr, 'confirmacao')+#13;
           inc(i);
           LeitorAux.free;
           Delete(strAux, PosI, count);
           posI := pos('<confirmacao>', strAux);
        end;
    end;

    Result := True;
  except
    result := False;
  end;
  *)
end;

function TretEnvLote.LerXml_proGoverna: Boolean;
var
  i, j, MsgErro: Integer;
  Msg: String;
begin
  try
    Leitor.Arquivo := RetirarPrefixos(Leitor.Arquivo);
    Leitor.Grupo   := Leitor.Arquivo;
    if (Leitor.rExtrai(1, 'RetornoLoteRps') <> '') then
    begin
      j := 0;
      i := 0;
      MsgErro := 0;
      while Leitor.rExtrai(1, 'RetornoLoteRps', '', i + 1) <> '' do
      begin
        while Leitor.rExtrai(2, 'DesOco', '', j + 1) <> '' do
        begin
          Msg  := Leitor.rCampo(tcStr, 'DesOco');
          if (Pos('OK!', Msg) = 0) and (Pos('importado com sucesso', Msg) = 0) then
          begin
            InfRec.FMsgRetorno.Add;
            InfRec.FMsgRetorno[MsgErro].FMensagem := Msg;
            Inc(MsgErro);
          end;
          inc(j);
        end;
        inc(i);
      end;
    end;
    Result := True;
  except
    Result := False;
  end;
end;

function TretEnvLote.LerXml_proCONAM: boolean;
var
  sMotCod,sMotDes: string;
  i: integer;
begin
  Result := False;
  try
    Leitor.Arquivo := RetirarPrefixos(Leitor.Arquivo);
    Leitor.Grupo   := Leitor.Arquivo;
    if leitor.rExtrai(1, 'Sdt_processarpsout') <> '' then begin
        FInfRec.FSucesso := Leitor.rCampo(tcStr, 'Id');
        if (FInfRec.FSucesso = 'Arquivo Aceito') then  begin
            FInfRec.FNumeroLote      := Leitor.rCampo(tcStr, 'Protocolo');
            FInfRec.FProtocolo       := Leitor.rCampo(tcStr, 'Protocolo');
            //FinfRec.FDataRecebimento := Leitor.rCampo(tcDatHor, 'dhRecbto')
        end;
        // if (FInfRec.FSucesso = '200') 200-Rejeitado
        if leitor.rExtrai(2, 'Messages') <> '' then begin
            i := 0;
            while Leitor.rExtrai(3, 'Message', '', i + 1) <> '' do begin
                sMotCod:=Leitor.rCampo(tcStr, 'Id');
                sMotDes:=Leitor.rCampo(tcStr, 'Description');

                InfRec.MsgRetorno.Add;
                InfRec.MsgRetorno[i].FCodigo   := sMotCod;
                InfRec.MsgRetorno[i].FMensagem := sMotDes;
                Inc(i);
            end;
        end;
    end;
    Result := True;
  except
    Result := False;
  end;
end;

function TretEnvLote.LerXml_proSP: Boolean;
var
  i: Integer;
begin
  Result := False;

  try
    Leitor.Arquivo := RetirarPrefixos(Leitor.Arquivo);
    Leitor.Grupo   := Leitor.Arquivo;

    if leitor.rExtrai(1, 'RetornoEnvioLoteRPS') <> '' then
    begin
      if (leitor.rExtrai(2, 'Cabecalho') <> '') then
      begin
        FInfRec.FSucesso := Leitor.rCampo(tcStr, 'Sucesso');

        if (leitor.rExtrai(3, 'InformacoesLote') <> '') then
        begin
          FInfRec.InformacoesLote.NumeroLote := Leitor.rCampo(tcStr, 'NumeroLote');
          FInfRec.InformacoesLote.InscricaoPrestador := Leitor.rCampo(tcStr, 'InscricaoPrestador');
          FInfRec.InformacoesLote.CPFCNPJRemetente := Leitor.rCampo(tcStr, 'CNPJ');
          if FInfRec.InformacoesLote.CPFCNPJRemetente = '' then
            FInfRec.InformacoesLote.CPFCNPJRemetente := Leitor.rCampo(tcStr, 'CPF');
          FInfRec.InformacoesLote.DataEnvioLote := Leitor.rCampo(tcDatHor, 'DataEnvioLote');
          FInfRec.InformacoesLote.QtdNotasProcessadas := Leitor.rCampo(tcInt, 'QtdeNotasProcessadas');
          FInfRec.InformacoesLote.TempoProcessamento := Leitor.rCampo(tcInt, 'TempoProcessamento');
          FInfRec.InformacoesLote.ValorTotalServico := Leitor.rCampo(tcDe2, 'ValorTotalServicos');
        end;
      end;

      i := 0;
      while Leitor.rExtrai(2, 'ChaveNFeRPS', '', i + 1) <> '' do
      begin
        FInfRec.FListaChaveNFeRPS.Add;

        if (leitor.rExtrai(3, 'ChaveNFe') <> '') then
        begin
          FInfRec.ListaChaveNFeRPS[i].ChaveNFeRPS.InscricaoPrestador := Leitor.rCampo(tcStr, 'InscricaoPrestador');
          FInfRec.ListaChaveNFeRPS[i].ChaveNFeRPS.Numero := Leitor.rCampo(tcStr, 'Numero');
          FInfRec.ListaChaveNFeRPS[i].ChaveNFeRPS.CodigoVerificacao := Leitor.rCampo(tcStr, 'CodigoVerificacao');
        end;

        if (leitor.rExtrai(3, 'ChaveRPS') <> '') then
        begin
          FInfRec.ListaChaveNFeRPS[i].ChaveNFeRPS.InscricaoPrestador := Leitor.rCampo(tcStr, 'InscricaoPrestador');
          FInfRec.ListaChaveNFeRPS[i].ChaveNFeRPS.SerieRPS := Leitor.rCampo(tcStr, 'SerieRPS');
          FInfRec.ListaChaveNFeRPS[i].ChaveNFeRPS.NumeroRPS := Leitor.rCampo(tcStr, 'NumeroRPS');
        end;

        Inc(i);
      end;

      i := 0;
      while Leitor.rExtrai(2, 'Alerta', '', i + 1) <> '' do
      begin
        FInfRec.MsgRetorno.Add;
        FInfRec.FMsgRetorno[i].FCodigo   := Leitor.rCampo(tcStr, 'Codigo');
        FInfRec.FMsgRetorno[i].FMensagem := Leitor.rCampo(tcStr, 'Descricao');
        FInfRec.FMsgRetorno[i].FCorrecao := '';

        if (leitor.rExtrai(3, 'ChaveNFe') <> '') then
        begin
          FInfRec.FMsgRetorno[i].FChaveNFeRPS.InscricaoPrestador := Leitor.rCampo(tcStr, 'InscricaoPrestador');
          FInfRec.FMsgRetorno[i].FChaveNFeRPS.Numero := Leitor.rCampo(tcStr, 'Numero');
          FInfRec.FMsgRetorno[i].FChaveNFeRPS.CodigoVerificacao := Leitor.rCampo(tcStr, 'CodigoVerificacao');
        end;

        if (leitor.rExtrai(3, 'ChaveRPS') <> '') then
        begin
          FInfRec.FMsgRetorno[i].FChaveNFeRPS.InscricaoPrestador := Leitor.rCampo(tcStr, 'InscricaoPrestador');
          FInfRec.FMsgRetorno[i].FChaveNFeRPS.SerieRPS := Leitor.rCampo(tcStr, 'SerieRPS');
          FInfRec.FMsgRetorno[i].FChaveNFeRPS.NumeroRPS := Leitor.rCampo(tcStr, 'NumeroRPS');
        end;

        Inc(i);
      end;

      i := 0;
      while Leitor.rExtrai(2, 'Erro', '', i + 1) <> '' do
      begin
        FInfRec.MsgRetorno.Add;
        FInfRec.FMsgRetorno[i].FCodigo   := Leitor.rCampo(tcStr, 'Codigo');
        FInfRec.FMsgRetorno[i].FMensagem := Leitor.rCampo(tcStr, 'Descricao');
        FInfRec.FMsgRetorno[i].FCorrecao := '';

        if (leitor.rExtrai(3, 'ChaveNFe') <> '') then
        begin
          FInfRec.FMsgRetorno[i].FChaveNFeRPS.InscricaoPrestador := Leitor.rCampo(tcStr, 'InscricaoPrestador');
          FInfRec.FMsgRetorno[i].FChaveNFeRPS.Numero := Leitor.rCampo(tcStr, 'Numero');
          FInfRec.FMsgRetorno[i].FChaveNFeRPS.CodigoVerificacao := Leitor.rCampo(tcStr, 'CodigoVerificacao');
        end;

        if (leitor.rExtrai(3, 'ChaveRPS') <> '') then
        begin
          FInfRec.FMsgRetorno[i].FChaveNFeRPS.InscricaoPrestador := Leitor.rCampo(tcStr, 'InscricaoPrestador');
          FInfRec.FMsgRetorno[i].FChaveNFeRPS.SerieRPS := Leitor.rCampo(tcStr, 'SerieRPS');
          FInfRec.FMsgRetorno[i].FChaveNFeRPS.NumeroRPS := Leitor.rCampo(tcStr, 'NumeroRPS');
        end;

        Inc(i);
      end;

      Result := True;
    end;
  except
    Result := False;
  end;
end;

end.