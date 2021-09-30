Rails.application.routes.draw do
  get "/", to: "receipts#index", as: "index_path"
  get "/result", to: "receipts#result"
end
