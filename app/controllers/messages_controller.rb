class MessagesController < ApplicationController
  def index
    @room = Room.find(params[:room_id])
    @message = Message.new
    @messages = @room.messages.includes(:user)
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end

end


# @roomには、Room.find(params[:room_id])と記述することで、paramsに含まれているroom_idを代入します。
# 紐解いて説明すると、直前の問題にあった通りルーティングをネストしているため/rooms/:room_id/messagesといったパスになります。
# パスにroom_idが含まれているため、paramsというハッシュオブジェクトの中に、room_idという値が存在しています。
# そのため、params[:room_id]と記述することでroom_idを取得できます。

# (params[:id])でなくて、(params[:room_id])の理由は
# Roomモデルから、Messageモデルを介しているから、(params[:room_id])と記載している

# @room.messages.newでチャットルームに紐づいたメッセージのインスタンスを生成し、message_paramsを引数にして、privateメソッドを呼び出します。
# その値を@messageに代入し、saveメソッドでメッセージの内容をmessagesテーブルに保存します。
# @message = @room.messages.new(message_params)はroomにmessageがネストしているから、
# Roomモデルに関連づいたmessagesテーブルに新しくレコードをつくるという意味。

# createアクション内に、メッセージを保存できた場合とできなかった場合で条件分岐の処理を行います。
# @message.saveでメッセージの保存に成功した場合、room_messages_path(@room)
# （参加しているチャットルームに投稿したメッセージの一覧画面）にリダイレクトし、失敗した場合、indexアクションが実行され、同じページに戻るという記述をします。

# チャットルームに紐付いている全てのメッセージ（@room.messages）を@messagesと定義します。
# そして、一覧画面で表示するメッセージ情報には、ユーザー情報も紐付いて表示されます。
# この場合、メッセージに紐付くユーザー情報の取得に、メッセージの数と同じ回数のアクセスが必要になるので、N+1問題が発生します。
# その場合は、includesメソッドを使用して、解消しましょう。
# 全てのメッセージ情報に紐づくユーザー情報を、includes(:user)と記述をすることにより、ユーザー情報を1度のアクセスでまとめて取得することができます。

# @messages = @room.messages.includes(:user)は
# インスタンス変数@messagesに@room(ある特定のroom_idをもつ)にある(紐づく)全てのmessageを入れて、そこにusersテーブルの情報も紐付ける。

# @room = Room.find(params[:room_id])にはある:room_idに関する全ての情報が入ってる。
# アソシエーションをおこなっているため、ある:room_idに関する他のテーブルの情報も入っている。