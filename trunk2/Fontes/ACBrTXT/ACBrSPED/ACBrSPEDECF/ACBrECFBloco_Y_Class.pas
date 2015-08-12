{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2014   Juliomar Marchetti                   }
{					                    2015   Isaque Pinheiro	    	             }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
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

{******************************************************************************
|* Historico
|*
*******************************************************************************}


{$I ACBr.inc}

unit ACBrECFBloco_Y_Class;

interface

uses
  SysUtils, Classes, DateUtils, ACBrSped, ACBrECFBloco_Y, ACBrECFBlocos,
  ACBrTXTClass, ACBrECFBloco_0_Class;

type
  /// TBloco_Y -

  { TBloco_Y }

  TBloco_Y = class(TACBrSPED)
  private
    FBloco_0: TBloco_0;
    FRegistroY001: TRegistroY001;
    FRegistroY990: TRegistroY990;
  public
    property Bloco_0: TBloco_0 read FBloco_0 write FBloco_0;

    constructor Create;
    destructor Destroy;

    procedure CriaRegistros;
    procedure LimpaRegistros;

    property RegistroY001: TRegistroY001 read FRegistroY001 write FRegistroY001;
    property RegistroY990: TRegistroY990 read FRegistroY990 write FRegistroY990;
  published
  end;

implementation

uses
  ACBrTXTUtils, StrUtils;

{ TBloco_Y }

constructor TBloco_Y.Create;
begin
  FRegistroY001 := TRegistroY001.Create;
  FRegistroY990 := TRegistroY990.Create;
end;

procedure TBloco_Y.CriaRegistros;
begin

end;

destructor TBloco_Y.Destroy;
begin
  FRegistroY001.Free;
  FRegistroY990.Free;
end;

procedure TBloco_Y.LimpaRegistros;
begin

end;

end.
