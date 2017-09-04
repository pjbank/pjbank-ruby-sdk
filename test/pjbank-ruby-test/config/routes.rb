Rails.application.routes.draw do
    # |URL que vai ser configurada| => |controlador|método do controlador|
    # Caso não exista o método no controlador, a URL irá redirecionar direto para a view
    get "recebimento" => "recebimento#index"
    get "recebimento/search" => "recebimento#search"
    get "teste" => "teste#index"
end


