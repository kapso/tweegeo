FactoryGirl.define do

  factory :tweet do
    user_handle 'user'
    text 'This is some random tweet'
    user_avatar_url 'http://some.random.url'
    tweet_id { (1 + rand(10000)).to_s }
    place_name 'New York, NY'
    location [ -77.423456, 42.989259 ]
    time Time.now
  end
  
end