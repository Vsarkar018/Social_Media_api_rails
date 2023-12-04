Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development? || Rails.env.staging?
  mount V1::BaseApi => '/'

end
