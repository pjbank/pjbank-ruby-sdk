Rails.application.routes.draw do
    # |URL que vai ser configurada| => |controlador|método do controlador|
    # Caso não exista o método no controlador, a URL irá redirecionar direto para a view
    get "teste" => "teste#index"
    get "recebimento" => "recebimento_teste#index"
    post "recebimento/credenciamento" => "recebimento_teste#credenciamento"
    post "recebimento/emitir" => "recebimento_teste#emitir"
    post "recebimento/emissao" => "recebimento_teste#emissao"
    post "recebimento/carne" => "recebimento_teste#carne"
end


