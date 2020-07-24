Rails.application.routes.draw do
  devise_for :users
  get 'messages/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # こちらは削除してOKです
  root "messages#index"
  resources :users, only: [:edit, :update]
  resources :rooms, only: [:new, :create]
end


# resources :rooms, only: [:new, :create]
# newビューでparamsを使うので、createアクションを定義しないと、newビューの時点でerrorが出る。
# NoMethodError in Rooms#new
# Showing /Users/ishidatakayoshi/projects/chat-app/app/views/rooms/new.html.erb where line #3 raised:
# undefined method `rooms_path' for #<#<Class:0x00007faf78dd50e8>:0x00007faf78ddf7c8>
# Did you mean?  root_path