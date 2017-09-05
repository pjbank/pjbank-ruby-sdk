require_relative 'pjbank-ruby-sdk'

puts "Testes: "
puts "1 - Recebimento/Boleto/Credenciamento"
puts "2 - Recebimento/Boleto/Emitir"
puts "3 - Recebimento/Boleto/Impressão em Lotes"
puts "4 - Recebimento/Boleto/Impressão de Carnê"
puts "5 - Recebimento/Cartão de Crédito/Credenciamento"
puts "6 - Recebimento/Cartão de Crédito/Tokenizar um cartão"
puts "7 - Recebimento/Cartão de Crédito/Criar transação com token"
puts "8 - Recebimento/Cartão de Crédito/Criar transação com dados do cartão"
puts "9 - Recebimento/Cartão de Crédito/Cancelar transação"

teste = gets.chomp

case teste
    when '1'
        PJBank::Recebimento.boleto(
            acao: :credenciamento, 
            dados: {
                nome_empresa: "Exemplo Conta Digital",
                conta_repasse: "99999-9",
                agencia_repasse: "00001",
                banco_repasse: "001",
                cnpj: "06949753000124",  
                ddd: "19",  
                telefone: "987652345",  
                email: "api@pjbank.com.br"
            }
        )
    when '2'
        PJBank::Recebimento.boleto(
            acao: :emitir, 
            aut: {
                'credencial': 'd3418668b85cea70aa28965eafaf927cd34d004c',
            },
            dados: {
                vencimento: "12/30/2019",
                valor: "1000.98",
                juros: "0.0",
                multa: "0.98",
                desconto: " 9.58",
                nome_cliente: "Cliente de exemplo",  
                cpf_cliente: "62936576000112",  
                endereco_cliente: "Rua Joaquim Vilac",  
                numero_cliente: 509,  
                complemento_cliente: "",  
                bairro_cliente: "Vila Teixeira",  
                cidade_cliente: "Campinas",  
                estado_cliente: "SP",  
                cep_cliente: "13301510",  
                logo_url: "http://wallpapercave.com/wp/xK64fR4.jpg",
                texto: "",
                grupo: "Boletos001",
                pedido_numero: "8972"
            }
        )
    when '3'
        PJBank::Recebimento.boleto(
            acao: :impressaoLote,
            aut: {
                'credencial': 'd3418668b85cea70aa28965eafaf927cd34d004c',
                'chave': '46e79d6d5161336afa7b98f01236efacf5d0f24b'
            },
            dados: {
                pedido_numero: 8972,
                # formato: "carne"
            }
        )
    when '4'
        PJBank::Recebimento.boleto(
            acao: :impressaoCarne, 
            aut: {
                'credencial': 'd3418668b85cea70aa28965eafaf927cd34d004c',
                'chave': '46e79d6d5161336afa7b98f01236efacf5d0f24b'
            },
            dados: {
                pedido_numero: 8972,
                formato: "carne"
            }
        )
    when '5'
        PJBank::Recebimento.cartao(
            acao: :credenciamento,
            dados: {
                nome_empresa: "Exemplo Conta Digital",
                conta_repasse: "99999-9",
                agencia_repasse: "00001",
                banco_repasse: "001",
                cnpj: "06949753000124",  
                ddd: "19",  
                telefone: "987652345",  
                email: "api@pjbank.com.br",
                cartao: "true"
            }
        )
    when '6'
        PJBank::Recebimento.cartao(
            acao: :tokenizar,
            aut: {
                'credencial_cartao': '1264e7bea04bb1c24b07ace759f64a1bd65c8560',
                'chave_cartao': 'ef947cf5867488f744b82744dd3a8fc4852e529f'
            },
            dados: {
                nome_cartao: "Cliente Exemplo",
                numero_cartao: "4318148832046011",
                mes_vencimento: "01",
                ano_vencimento: "2019",
                cpf_cartao: "24322121004",
                email_cartao: "api@pjbank.com.br",
                celular_cartao: "978456723",
                codigo_cvv: "155"
            }
        )
    when '7'
        PJBank::Recebimento.cartao(
            acao: :emitirToken,
            aut: {
                'credencial_cartao': '1264e7bea04bb1c24b07ace759f64a1bd65c8560',
                'chave_cartao': 'ef947cf5867488f744b82744dd3a8fc4852e529f'
            },
            dados: {
                token_cartao: "a8acb8de818d428844fee52a48ea3b075d8c9f0e",
                valor: "10",
                parcelas: "2",
                descricao_pagamento: "Pagamento de teste"
            }
        )
    when '8'
        PJBank::Recebimento.cartao(
            acao: :emitirCartao,
            aut: {
                'credencial_cartao': '1264e7bea04bb1c24b07ace759f64a1bd65c8560',
                'chave_cartao': 'ef947cf5867488f744b82744dd3a8fc4852e529f'
            },
            dados: {
                numero_cartao: "4012001037141112",
                nome_cartao: "Cliente Exemplo",
                mes_vencimento: "05",
                ano_vencimento: "2018",
                cpf_cartao: "37843514171",
                email_cartao: "api@pjbank.com.br",
                celular_cartao: "1187906534",
                codigo_cvv: "123",
                valor: "10",
                parcelas: "2",
                descricao_pagamento: "Pagamento de teste"
            }
        )
    when '9'
        PJBank::Recebimento.cartao(
            acao: :cancelarTransacao,
            aut: {
                'credencial_cartao': '1264e7bea04bb1c24b07ace759f64a1bd65c8560',
                'chave_cartao': 'ef947cf5867488f744b82744dd3a8fc4852e529f',
                'tid_cartao': '2017000006910011775476'
            }
        )
end