class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,  :validatable
  validates :name, presence: true

  has_many :room_users
  has_many :rooms, through: :room_users
end


# Userモデルに、validates :name, presence: trueを追記します。
# 「name」カラムに、presence: trueを設けることで、空の場合はDBに保存しないというバリデーションを設定しています。
# つまり、ユーザー登録時に「name」を空欄にして登録しようとすると、エラーが発生します。