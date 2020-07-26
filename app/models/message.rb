class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one_attached :image
  validates :content, presence: true, unless: :was_attached?

  def was_attached?
    self.image.attached?
  end

end




# 「has_one_attached」とは、各レコードと画像ファイルを1対1の関係で紐づけることができます。つまり、記述したモデルの各レコードは1つの画像ファイルを添付できます。
# 今回であれば、message.rbにhas_one_attachedを記述しています。これによりMessagesテーブルの各レコードと画像ファイルを管理するimageカラムの紐付けに成功しました。
# この時、Messagesテーブルにカラムを追加する必要はありません。

# has_one_attached :image
# Messagesテーブルにimageカラムを加えるイメージ(実際には追加されてない。)Active Storageを導入した場合使える。