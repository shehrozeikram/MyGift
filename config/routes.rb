require 'sidekiq/web'

Rails.application.routes.draw do


  get 'shopping_carts/index'
  mount Sidekiq::Web => '/jobmonitor'

  devise_for :users, as: "web"




  get  '/users/:id/profile', to: 'users#profile', as: "my_profile"
  get  '/users/:id/edit_profile', to: 'users#edit_profile', as: "edit_profile"
  get  '/users/set_current_locale', to: 'users#set_current_locale', as: "set_current_locale"


  resource :service do
    get '/index', to: "services#index"
    get '/shop', to: "services#shop"
    get '/facilities', to: "services#facilities"
    get '/individual', to: "services#individual"
    get '/appartments', to: "services#appartments"
    get '/get_time_slots', to: "services#get_time_slots"
    post '/book_appointment', to: "services#book_appointment"
  end

  root to: "services#index"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount_devise_token_auth_for 'User', at: '/api/v1/users', controllers: {
    registrations: 'api/v1/registrations',
    sessions: 'api/v1/sessions',
    passwords: 'api/v1/passwords',
    token_validations: 'api/v1/token_validations'
  }, skip: %i[omniauth_callbacks registrations]



  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/default_locales', to: 'api#default_locales'

      resource :user, only: %i[show update]

      devise_scope :user do
        resources :users, only: [] do
          controller :registrations do
            post :create, on: :collection
          end
        end
      end

      resource :ad do
        get '/fetch_ads', to: 'ads#ads'
      end

      resource :stores do

        get '/login_store', to: 'stores#login_store'
        post '/create_store', to: 'stores#create_store'
        get '/fetch_stores', to: 'stores#fetch_stores'
        get '/fetch_store_id', to: 'stores#fetch_store_id'
        post '/create_store_payment', to: 'stores#create_store_payment'
        post '/contact_us', to: 'stores#contact_us'
        get '/fetch_notifications', to: 'stores#fetch_notifications'
        post '/create_withdraw', to: 'stores#create_withdraw'
        get '/pending_requests', to: 'stores#pending_requests'
        get '/approved_requests', to: 'stores#approved_requests'
        put '/update_request', to: 'stores#update_request'
        get '/fetch_store_wallet', to: 'stores#fetch_store_wallet'
        get '/fetch_store_balance', to: 'stores#fetch_store_balance'
      end



      resource :cards do
        get '/fetch_cards', to: 'cards#fetch_cards'
        post '/create_gift', to: 'cards#create_gift'
        put '/claim_reward', to: 'cards#claim_reward'
        get '/fetch_transactions', to: 'cards#fetch_transactions'
        get '/fetch_rewards', to: 'cards#fetch_rewards'
        get '/fetch_claim_rewards', to: 'cards#fetch_claim_rewards'
        get '/fetch_user_wallet', to: 'cards#fetch_user_wallet'
      end


      resource :business do
        get '/show_business', to: 'businesses#show_business'
        get '/fetch_business', to: 'businesses#fetch_business'
        get '/fetch_user_list', to: 'businesses#fetch_user_list'
      end

      resource :order do
        post '/create_order', to: 'orders#create_order'
      end


    end
  end
end
