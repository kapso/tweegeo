namespace :app do

  desc 'Fetch Tweets Task'
  task fetch_tweets: :environment do
    Worker::TwitterStream.start
  end

end