Rails.application.routes.draw do



  # Section for user dashboard
  # ------------- SECTION START -------------
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }, skip: [:sessions, :passwords, :confirmations, :registrations]
  get '/my', to: redirect('/my/dashboard'), as: 'my_index'
  get '/my/dashboard', to: 'user_cabinet#index', as: 'user_cabinet_index'
  get '/my/dashboard/history', to: 'user_cabinet#history', as: 'user_cabinet_history'
  get '/my/dashboard/subscribe', to: 'user_cabinet#subscribe', as: 'user_cabinet_subscribe'
  devise_scope :user do
    # session handling
    get     '/my/dashboard/login'  => 'devise/sessions#new',     as: 'new_user_session'
    post    '/my/dashboard/login'  => 'devise/sessions#create',  as: 'user_session'
    delete  '/my/dashboard/logout' => 'devise/sessions#destroy', as: 'destroy_user_session'

    # joining
    get   '/my/dashboard/join' => 'devise/registrations#new',    as: 'new_user_registration'
    post  '/my/dashboard/join' => 'devise/registrations#create', as: 'user_registration'
    put   '/my/dashboard/join' => 'devise/registrations#update'
    delete '/my/dashboard/join' => 'devise/registrations#destroy'

    scope '/my/dashboard/account' do
      # password reset
      get   '/reset-password'        => 'devise/passwords#new',    as: 'new_user_password'
      put   '/reset-password'        => 'devise/passwords#update', as: 'user_password'
      post  '/reset-password'        => 'devise/passwords#create'
      get   '/reset-password/change' => 'devise/passwords#edit',   as: 'edit_user_password'

      # confirmation
      get   '/confirm'        => 'devise/confirmations#show',   as: 'user_confirmation'
      post  '/confirm'        => 'devise/confirmations#create'
      get   '/confirm/resend' => 'devise/confirmations#new',    as: 'new_user_confirmation'

      # settings & cancellation
      get '/cancel'   => 'devise/registrations#cancel', as: 'cancel_user_registration'
      get '/settings' => 'devise/registrations#edit',   as: 'edit_user_registration'
      put '/settings' => 'devise/registrations#update'

      # account deletion
      delete '' => 'devise/registrations#destroy'#, as: 'delete_user_registration'
    end

  end  # ------------- SECTION END -------------

    root 'page#index'

end
