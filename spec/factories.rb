FactoryGirl.define do

  factory :tweet do
    sequence(:user_handle) { |n| "user#{n}" }
    text "Here's an interesting tweet"
    user_avatar_url 'http://s3.image.url'
    tweet_id { (1 + rand(10000)).to_s }
    place_name 'New York, NY'
    location [ -77.423456, 42.989259 ]
    time Time.now
  end
  
end