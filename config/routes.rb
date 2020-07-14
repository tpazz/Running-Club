Rails.application.routes.draw do

  # Resources and patch files
  resources :events
  resources :injury_records
  resources :attendances
  resources :session_helpers
  resources :schedules do
    patch :assign_coaches, on: :member
  end
  resources :documents
  resources :coaches do
    patch :my_account_coach, on: :member
    #get :delete_coach, on: :collection
  end
  resources :emergency_contacts
  resources :phone_numbers
  resources :children do
    patch :mark_attendance, on: :member
    patch :approve_children, on: :member
    patch :move_members, on: :member
    patch :view_children_payments, on: :member
    patch :med_details, on: :member
  end
  resources :parents do
    patch :my_account_parent, on: :member
    #get :delete_parent, on: :collection
  end
  resources :groups do
    patch :make_inactive, on: :member
    patch :make_active, on: :member
  end
  resources :roles do
    patch :my_account_users, on: :member
  end
  resources :user_roles

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'forgot_password', to: 'devise/passwords#new'
    get '/signup', to: 'signup#new'
    get 'change_password', to: 'devise/registrations#edit'
  end

  # Errors
  devise_for :users
  match "/403", to: "errors#error_403", via: :all
  match "/404", to: "errors#error_404", via: :all
  match "/422", to: "errors#error_422", via: :all
  match "/500", to: "errors#error_500", via: :all

  get :ie_warning, to: 'errors#ie_warning'
  get :javascript_warning, to: 'errors#javascript_warning'

  # Homepage
  unauthenticated do
   root :to => 'pages#application'
  end

  authenticated do
    root :to => 'pages#post_signin'
  end

  # Gallery
  get 'gallery', to: 'gallery#index', as: 'gallerys'
  get '/images/:id/display', to: 'gallery#display', as: 'secure_image_display'
  post 'gallery_create', to: 'gallery#create', as: 'gallery_create'
  delete 'gallery_destroy/:name', to: 'gallery#destroy', as: 'gallery_destroy'
  get 'admin/new', to: 'pages#new_admin'
  post 'admin/new', to: 'pages#new_admin_post'

  # Public pages for everyone
  post "/signup", to: "signup#signup"
  get "coach_registration", to: "signup#new_coach"
  post "coach_registration", to: "signup#coach_registration"
  get "schedule", to: "schedules#index"
  get "visitor_events", to: "pages#visitor_events"
  get "contact_us", to: "email#contact_email"
  post "contact_us_sent", to: "email#contact_email2"
  # End public pages

  # Have Permission
  get "add_users", to:"pages#add_users"
  get "assign_coaches", to: "pages#assign_coaches"
  get "med_details", to: "pages#med_details"
  get "my_children_details", to:"pages#my_children_details"
  get "childrens_group", to: "pages#childrens_group"
  get "view_children_payments", to: "pages#view_children_payments"
  get "post_signin", to: "pages#post_signin"
  get "attendance", to: "pages#attendance"
  get "gallery", to: "gallery#index"
  get "basic_attendance", to: "pages#basic_attendance"
  get "my_account_parent", to: "pages#my_account_parent"
  get "my_account_coach", to: "pages#my_account_coach"
  get "my_account_users", to: "pages#my_account_users"
  get "reset_payments", to: "pages#reset_payments"
  get "payment_done", to: "pages#payment_done"
  get "my_children", to: "pages#my_children"
  get "edit_children", to: "pages#edit_children"
  get "add_child", to: "pages#add_child"
  post "add_child", to: "pages#postchild"
  get "our_events", to: "pages#our_events"
  get "approve_children", to: "pages#approve_children"
  get "numbers_coaches", to: "pages#numbers_coaches"
  get "move_members", to: "pages#move_members"
  get "scheduleEdit", to: "schedules#indexEdit"

  #email forms
  get "email_groups", to: "email#email_group"
  get "email_user", to: "email#email_user"
  get "email_coaches", to: "email#email_coach"
  get "email_expiration", to: "email#email_expiration"
  get "email_application_status", to: "email#email_application_status"
  post "message_group", to: "email#email_group2"
  post "message_group_sent", to: "email#email_group3"
  post "search_results", to: "email#email_user2"
  post "message_user", to: "email#email_user3"
  post "message_user_sent", to: "email#email_user4"
  post "message_coach", to: "email#email_coach2"
  post "message_coach_sent", to: "email#email_coach3"
  post "application_status", to: "email#email_application_status2"
  post "reminder_sent", to: "email#email_expiration2"
  # End Permission

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
