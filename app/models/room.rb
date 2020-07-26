class Room < ApplicationRecord
  has_many :room_users
  has_many :users, through: :room_users, dependent: :destroy
  has_many :messages, dependent: :destroy
  
  validates :name, presence: true
  
  end


# 「dependent: :destroyオプション」とは、親モデルが削除された時、それに紐付ている子モデルも一緒に削除されるというオプションです。
# 本アプリで言うと、room（親モデル）が削除された時にmessage（子モデル）とuser（子モデル）も削除される、ということです。
# ここで注意なのが、あくまでも「チャットルームに紐づいているユーザー情報を削除」なので、「メンバーの削除＝中間テーブルから該当するレコード削除」ということになります。
# 一度登録したユーザー情報はusersテーブルに残ったままです。