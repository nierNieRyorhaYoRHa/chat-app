FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}
    association :user
    association :room
  end
end


# association :userと記述していますが、これはusers.rbのFactoryBotとアソシエーションがあることを意味します。
# つまり、Tweetのインスタンスが生成したと同時に、関連するUserのインスタンスも生成されます。 
# Tweetに対しては、必ずUserが紐付いている必要があるため、このように記述する必要があるのです。（UserはTweetを必ず持っているわけではないので、users.rbには記述しません）