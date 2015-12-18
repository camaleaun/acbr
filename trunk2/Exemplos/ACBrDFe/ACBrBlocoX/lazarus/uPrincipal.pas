unit uPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ACBrBlocoX, ACBrBlocoX_Comum;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
    ACBrBlocoX1: TACBrBlocoX;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.lfm}

{ TfrmPrincipal }

procedure TfrmPrincipal.Button3Click(Sender: TObject);
begin
  Edit1.Text := ACBrBlocoX1.SSL.SelecionarCertificado;
end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
var
  I: Integer;
begin
  if SaveDialog1.Execute then
  begin
    with ACBrBlocoX1 do
    begin
      Configuracoes.Certificados.NumeroSerie := Edit1.Text;
      Configuracoes.Certificados.Senha       := Edit2.Text;

      Estabelecimento.Ie              := '123456789';
      Estabelecimento.Cnpj            := '99999999999999';
      Estabelecimento.NomeEmpresarial := 'NOME EMPRESARIAL';

      PafECF.Versao                       := '01.01.01';
      PafECF.NumeroCredenciamento         := '123456ABC';
      PafECF.NomeComercial                := 'NOME COMERCIAL';
      PafECF.NomeEmpresarialDesenvolvedor := 'NOME EMPRESARIAL DO DESENVOLVEDOR';
      PafECF.CnpjDesenvolvedor            := '88888888888888';

      // arquivo de Estoque
      with Estoque do
      begin
        DataReferenciaInicial := DATE;
        DataReferenciaFinal   := DATE;

        for I := 1 to 10 do
        begin
          with Produtos.Add do
          begin
            Codigo.Tipo             := tpcGTIN;
            Codigo.Numero           := '7891234567891';
            Descricao               := 'PRODUTO TESTE ' + IntToStr(I);
            ValorUnitario           := 1.23;
            Ippt                    := ipptTerceiros;
            SituacaoTributaria      := stTributado;
            Aliquota                := 12;
            Unidade                 := 'UN';
            Quantidade              := 1234;
            IndicadorArredondamento := False;
          end;
        end;

        SaveToFile(SaveDialog1.FileName);
        ShowMessage('terminado');
      end;
    end;
  end;
end;

procedure TfrmPrincipal.Button2Click(Sender: TObject);
var
  I, X: Integer;
begin
  if SaveDialog1.Execute then
  begin
    with ACBrBlocoX1 do
    begin
      Configuracoes.Certificados.NumeroSerie := Edit1.Text;
      Configuracoes.Certificados.Senha       := Edit2.Text;

      Estabelecimento.Ie              := '123456789';
      Estabelecimento.Cnpj            := '99999999999999';
      Estabelecimento.NomeEmpresarial := 'NOME EMPRESARIAL';

      PafECF.Versao                       := '01.01.01';
      PafECF.NumeroCredenciamento         := '123456ABC';
      PafECF.NomeComercial                := 'NOME COMERCIAL';
      PafECF.NomeEmpresarialDesenvolvedor := 'NOME EMPRESARIAL DO DESENVOLVEDOR';
      PafECF.CnpjDesenvolvedor            := '88888888888888';

      ECF.NumeroFabricacao := 'BR1234567891234579';
      ECF.Tipo             := 'ECF-IF';
      ECF.Marca            := 'MARCA ECF';
      ECF.Modelo           := 'MODELO ECF';
      ECF.Versao           := '010101';

      with ReducoesZ do
      begin
        ReducoesZ.DataReferencia   := DATE;
        ReducoesZ.CRZ              := 12;
        ReducoesZ.CRO              := 12345679;
        ReducoesZ.VendaBrutaDiaria := 3456.78;
        ReducoesZ.GT               := 123456789.45;

        for I := 1 to 2 do
        begin
          with TotalizadoresParciais.Add do
          begin
            Identificao := '00T1234';
            Valor       := 1234.56;

            for X := 1 to 2 do
            begin
              with Produtos.Add do
              begin
                Codigo.Tipo   := tpcProprio;
                Codigo.Numero := IntToStr(X);
                Descricao     := 'PRODUTO ' + IntToStr(X);
                Quantidade    := 1234556;
                Unidade       := 'UN';
                ValorUnitario := 1234.99;
              end;
            end;

            for X := 1 to 2 do
            begin
              with Servicos.Add do
              begin
                Codigo.Tipo   := tpcProprio;
                Codigo.Numero := IntToStr(X);
                Descricao     := 'SERVICO ' + IntToStr(X);
                Quantidade    := 1234556;
                Unidade       := 'UN';
                ValorUnitario := 1234.99;
              end;
            end;
          end;
        end;

        SaveToFile(SaveDialog1.FileName);
        ShowMessage('terminado');
      end;
    end;
  end;
end;

end.

