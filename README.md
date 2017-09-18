# pjbank-ruby-sdk
PJBank SDK para Ruby! :diamonds: :diamonds: :diamonds:

![Construcao](https://openclipart.org/image/2400px/svg_to_png/231626/underconstruction.png)

## Instalação

Navegue até raiz do projeto e rode o comando abaixo para realizar a instalação da Gem:

    $ gem install pjbank-ruby-sdk

Após a instalação da Gem, coloque as linhas abaixo no arquivo Gemfile, dê sua aplicação Rails:

    gem "rest-clien", '~> 2.0'
    gem "pjbank-ruby-sdk", '~> 0.1.0'

Por fim, atualize o bundle de sua aplicação:

    bundle install

## Uso

Para realizar chamadas em uma aplicação Rails, é necessário chamar as classes e métodos desejados, através do módulo PJBank. Segue lista de classes e métodos disponíveis:

Classe: Recebimento<br>
Métodos: 
* [boleto](https://docs.pjbank.com.br/#820dd8c7-79e5-4df8-c413-ab195362d311) - Ações: <a href="https://docs.pjbank.com.br/#eec6e8b5-3634-4e39-5bba-c37594afceda" target="_blank">credenciamento</a> | <a href="https://docs.pjbank.com.br/#530279a2-bf8e-3af2-43c6-ff302845f0c0" target="_blank">emitir</a> | <a href="https://docs.pjbank.com.br/#11daeeab-fc33-ecc5-46e5-325b906796ed" target="_blank">impressaoLote</a> | <a href="https://docs.pjbank.com.br/#36c05fc4-0901-f3bb-077b-51178d9ce2b7" target="_blank">impressaoCarne</a>
* [cartao](https://docs.pjbank.com.br/#80a47dce-f30f-f502-cde8-5ee829e42279) - Ações: <a href="https://docs.pjbank.com.br/#6b249342-6376-925c-f920-0703069407f6" target="_blank">credenciamento</a> | <a href="https://docs.pjbank.com.br/#af15c310-3778-5ecf-fe12-c0aa3f8376ed" target="_blank">tokenizar</a> | <a href="https://docs.pjbank.com.br/#5732b1dd-4031-8018-8912-a79dd186cf76" target="_blank">emitirToken</a> | <a href="https://docs.pjbank.com.br/#a4af3d03-7bd4-1afb-bc4e-082595db9374" target="_blank">emitirCartao</a> | <a href="https://docs.pjbank.com.br/#3fc57c0d-4b60-331a-0e40-2fe2992e36c7" target="_blank">cancelarTransacao</a>
* [extrato](https://docs.pjbank.com.br/#32426ccf-1283-c2cc-4003-74bfb9764236) - Ações: <a href="https://docs.pjbank.com.br/#aeac7b38-1cda-cbdf-ced0-19fd031e43f6" target="_blank">pagamentos</a> | <a href="https://docs.pjbank.com.br/#a1f847d2-a1de-7aa2-fbd1-9b5b17aa94ea" target="_blank">pagamentosLiquidados</a> | <a href="https://docs.pjbank.com.br/#c6946e68-3b94-ef66-3a00-f15128d478fe" target="_blank">pagamentosFiltrados</a> | <a href="https://docs.pjbank.com.br/#2bff2e30-47e6-4571-e358-32f110de4f47" target="_blank">pagamentosPaginados</a>

## Exemplos

Exemplo de como realizar um credenciamento, para começar a receber com boleto bancário:

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

Exemplo de como tokenizar um cartão de crédito:

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






