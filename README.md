# pjbank

PJBank SDK para Ruby! :diamonds: :diamonds: :diamonds:

![Construcao](https://openclipart.org/image/2400px/svg_to_png/231626/underconstruction.png)

## Instalação

Adicione a linha abaixo ao Gemfile de sua applicação:

```ruby
gem 'pjbank', '~> 0.1.0'
```

Em seguida execute:

```
$ bundle install
```

Ou instale diretamente:

```
$ gem install pjbank
```

## Uso

Use `PJBank.configure` para fazer o setup do seu ambiente, podendo ser adicionado à um arquivo nos initilizers de sua
app Rails.

```ruby
require 'pjbank'

PJBank.configure do |config|
  # Define o ambiente em que serão feitas as requisições. O valor padrão
  # é "production". Pode ser definido como "production" ou qualquer outro
  # valor. Caso não seja "production" será utilizado o ambiente sandbox.
  config.env = Rails.env
  # Define o header User-Agent das requisições. O valor padrão
  # é "pjbank-ruby-sdk/<versão>".
  config.user_agent = "minha app/versão"
end
```

Para realizar chamadas, instancie um client (`PJBank::Client`), e chame os métodos desejados:

**[Recebimentos (para quem não tem conta digital)](https://docs.pjbank.com.br/#071783b5-8381-61c1-10b2-71835bf00140)**

* [boleto](https://docs.pjbank.com.br/#820dd8c7-79e5-4df8-c413-ab195362d311)
  - [credenciamento](https://docs.pjbank.com.br/#eec6e8b5-3634-4e39-5bba-c37594afceda)
  - [emitir](https://docs.pjbank.com.br/#530279a2-bf8e-3af2-43c6-ff302845f0c0)
  - [cancelar](https://docs.pjbank.com.br/#f5d4ff03-ecd6-0134-dfad-ec8a55e64e4c)
  - impressao: [normal](https://docs.pjbank.com.br/#11daeeab-fc33-ecc5-46e5-325b906796ed), [carne](https://docs.pjbank.com.br/#36c05fc4-0901-f3bb-077b-51178d9ce2b7)
  - transacoes: [todas](https://docs.pjbank.com.br/#aeac7b38-1cda-cbdf-ced0-19fd031e43f6), [liquidadas](https://docs.pjbank.com.br/#a1f847d2-a1de-7aa2-fbd1-9b5b17aa94ea),
  [filtradas por data](https://docs.pjbank.com.br/#c6946e68-3b94-ef66-3a00-f15128d478fe),
  [paginadas](https://docs.pjbank.com.br/#2bff2e30-47e6-4571-e358-32f110de4f47)
* [cartao](https://docs.pjbank.com.br/#80a47dce-f30f-f502-cde8-5ee829e42279)
  - [credenciamento](https://docs.pjbank.com.br/#6b249342-6376-925c-f920-0703069407f6)
  - [tokenizar](https://docs.pjbank.com.br/#af15c310-3778-5ecf-fe12-c0aa3f8376ed)
  - emitir: [usando token](https://docs.pjbank.com.br/#5732b1dd-4031-8018-8912-a79dd186cf76), [usando dados do cartão](https://docs.pjbank.com.br/#a4af3d03-7bd4-1afb-bc4e-082595db9374)
  - [cancelar](https://docs.pjbank.com.br/#3fc57c0d-4b60-331a-0e40-2fe2992e36c7)
  - transacoes: [todas](https://docs.pjbank.com.br/#aeac7b38-1cda-cbdf-ced0-19fd031e43f6), [liquidadas](https://docs.pjbank.com.br/#a1f847d2-a1de-7aa2-fbd1-9b5b17aa94ea),
  [filtradas por data](https://docs.pjbank.com.br/#c6946e68-3b94-ef66-3a00-f15128d478fe),
  [paginadas](https://docs.pjbank.com.br/#2bff2e30-47e6-4571-e358-32f110de4f47)

### Exemplos

```ruby
# Exemplo de como realizar um credenciamento, para começar a receber com boleto bancário:

client = PJBank::Client.new

response = client.recebimentos.boleto.credenciamento(
  nome_empresa:    "Exemplo Conta Digital",
  conta_repasse:   "99999-9",
  agencia_repasse: "00001",
  banco_repasse:   "001",
  cnpj:            "06949753000124",
  ddd:             "19",
  telefone:        "987652345",
  email:           "api@pjbank.com.br"
)

# Exemplo de como imprimir boletos:

client = PJBank::Client.new(
  credencial: "d3418668b85cea70aa28965eafaf927cd34d004c",
  chave:      "46e79d6d5161336afa7b98f01236efacf5d0f24b")

response = client.recebimentos.boleto.impressao(pedido_numero: ["89722"])
response.status     # 200
response.linkBoleto # "https://api.pjbank.com.br/boletos/lotes/abc4b7b017a47d9a345f273e89618ee6319ee308"

# Exemplo de como tokenizar um cartão de crédito:

client = PJBank::Client.new(
  credencial: "1264e7bea04bb1c24b07ace759f64a1bd65c8560",
  chave:      "ef947cf5867488f744b82744dd3a8fc4852e529f")

response = client.recebimento.cartao.tokenizar(
  nome_cartao:    "Cliente Exemplo",
  numero_cartao:  "4318148832046011",
  mes_vencimento: "01",
  ano_vencimento: "2019",
  cpf_cartao:     "24322121004",
  email_cartao:   "api@pjbank.com.br",
  celular_cartao: "978456723",
  codigo_cvv:     "155"
)
```

### Erros

Quando ocorrer um timeout, será levantado o erro `PJBank::RequestTimeout`.

Outros erros, levantam um erro `PJBank::RequestError` que responde aos métodos `code`, `message` e `body`.
