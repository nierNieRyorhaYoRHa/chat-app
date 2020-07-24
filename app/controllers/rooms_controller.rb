class RoomsController < ApplicationController

  def index
    
  end
  
  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, user_ids:[])
  end
end


# チャットルームの新規作成なので「new」アクションを定義します。
# また、form_withに渡す引数として、値が空のRoomインスタンスを@roomに代入しています。

# この中に、user_ids: []という記述があります。このように、配列に対して保存を許可したい場合は、キーの名称と関連づけてバリューに「[]」と記述します。