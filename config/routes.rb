Rails.application.routes.draw do
  devise_for :users
  get 'messages/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # こちらは削除してOKです
  root "rooms#index"
  resources :users, only: [:edit, :update]
  resources :rooms, only: [:new, :create, :destroy] do
    resources :messages, only: [:index, :create]
  end
end


# resources :rooms, only: [:new, :create]
# newビューでparamsを使うので、createアクションを定義しないと、newビューの時点でerrorが出る。
# NoMethodError in Rooms#new
# Showing /Users/ishidatakayoshi/projects/chat-app/app/views/rooms/new.html.erb where line #3 raised:
# undefined method `rooms_path' for #<#<Class:0x00007faf78dd50e8>:0x00007faf78ddf7c8>
# Did you mean?  root_path

# メッセージを投稿する際には、どのルームで投稿されたメッセージなのかをパスから判断できるようにしたいので、ルーティングのネストを利用します。
# 今回の場合、ネストをすることにより、roomsが親で、messagesが子という親子関係になるので、チャットルームに属しているメッセージという意味になります。
# これによって、メッセージに結びつくルームのidの情報を含んだパスを、受け取れるようになります。