Rails.application.routes.draw do
    # |URL que vai ser configurada| => |controlador|método do controlador|
    # Caso não exista o método no controlador, a URL irá redirecionar direto para a view
    get "/" => "index#index"
    get "recebimento" => "index#index"

    get "recebimento/boleto" => "recebimento_teste#index"
    post "recebimento/boleto/credenciamento" => "recebimento_teste#credenciamento"
    post "recebimento/boleto/emitir" => "recebimento_teste#emitir"
    post "recebimento/boleto/emissao" => "recebimento_teste#emissao"
    post "recebimento/boleto/carne" => "recebimento_teste#carne"

    get "recebimento/cartao" => "recebimento_cartao#index"
end


