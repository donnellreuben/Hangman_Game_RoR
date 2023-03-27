Rails.application.routes.draw do
  get "/hangman", controller: "game", action: "start"
  
  post "/guess", controller: "game", action: "guess"
end
