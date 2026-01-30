Rails.application.routes.draw do
  
  controller :static_pages do
    get 'about',   action: :about
    get 'home',    action: :home
    get 'secret', action: :secret
    get 'sign_in', action: :sign_in
    get 'sign_out', action: :sign_out
  end

  controller :sessions do
    post 'sign_in', action: :create
    delete 'sign_out', action: :destroy
  end

  root 'static_pages#splash'

end
