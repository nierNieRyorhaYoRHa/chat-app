class MessagesController < ApplicationController
  def index
    @room = Room.find(params[:room_id])
    @message = Message.new
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
    params.require(:message).permit(:content).merge(user_id: current_user.id)
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
