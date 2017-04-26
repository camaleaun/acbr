{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2013 Andr� Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esse arquivo usa a classe  PCN (c) 2009 - Paulo Casagrande                  }
{  PCN - Projeto Cooperar NFe       (Found at URL:  www.projetocooperar.org)   }
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

unit pcnEnviarPagamentoW;

interface

uses
  SysUtils, Classes,
  pcnConversao, pcnGerador, pcnEnviarPagamento, pcnMFeUtil, ACBrUtil;

type

  { TEnviarPagamentoW }

  TEnviarPagamentoW = class(TPersistent)
  private
    FGerador: TGerador;
    FEnviarPagamento: TEnviarPagamento;
    function GetOpcoes: TGeradorOpcoes;
  public
    constructor Create(AOwner: TEnviarPagamento);
    destructor Destroy; override;
    function GerarXml: boolean;
  published
    property Gerador: TGerador read FGerador ;
    property EnviarPagamento: TEnviarPagamento read FEnviarPagamento write FEnviarPagamento;
    property Opcoes: TGeradorOpcoes read GetOpcoes ;
  end;


implementation

{ TEnviarPagamentoW }

constructor TEnviarPagamentoW.Create(AOwner: TEnviarPagamento);
begin
  FEnviarPagamento := AOwner;
  FGerador := TGerador.Create;
end;

destructor TEnviarPagamentoW.Destroy;
begin
  FGerador.Free;
  inherited Destroy;
end;

function TEnviarPagamentoW.GetOpcoes: TGeradorOpcoes;
begin
  Result := FGerador.Opcoes;
end;

function TEnviarPagamentoW.GerarXml(): boolean;
var
  Identificador : TIdentificador;
  Construtor : TConstructor;
  Parametro: TParametro;
begin
  Gerador.LayoutArquivoTXT.Clear;

  Gerador.ArquivoFormatoXML := '';
  Gerador.ArquivoFormatoTXT := '';

  Gerador.wGrupo('Integrador');
  Identificador := TIdentificador.Create(Gerador);
  try
    Identificador.GerarIdentificador(EnviarPagamento.Identificador);
  finally
    Identificador.Free;
  end;

  Construtor := TConstructor.Create(Gerador);
  try
    Construtor.GerarConstructor('chaveAcessoValidador', EnviarPagamento.ChaveAcessoValidador);
  finally
    Construtor.Free;
  end;

  Gerador.wGrupo('Parametros');

  Parametro := TParametro.Create(Gerador);
  try
    Parametro.GerarParametro('chaveRequisicao'  , EnviarPagamento.ChaveRequisicao, tcStr);
    Parametro.GerarParametro('estabelecimento'  , EnviarPagamento.Estabelecimento, tcStr);
    Parametro.GerarParametro('serialPOS'        , EnviarPagamento.SerialPOS, tcStr);
    Parametro.GerarParametro('Cnpj'             , EnviarPagamento.CNPJ, tcStr);
    Parametro.GerarParametro('valorOperacaoSujeitaICMS', EnviarPagamento.ValorOperacaoSujeitaICMS, tcStr);
    Parametro.GerarParametro('valorTotalVenda'  , EnviarPagamento.ValorTotalVenda, tcStr);
  finally
    Parametro.Free;
  end;

  Gerador.wGrupo('/Parametros');
  Gerador.wGrupo('/Integrador');

  Result := (Gerador.ListaDeAlertas.Count = 0);
end;

end.

