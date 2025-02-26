Rails.application.routes.draw do
  post "/shorten", to: "shortened_urls#create"
  get "/:slug", to: "shortened_urls#redirect"
end
