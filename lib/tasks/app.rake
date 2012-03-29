namespace :app do

  desc 'Fetch Tweets Task'
  task fetch_tweets: :environment do
    Worker::TwitterStream.start
  end

  desc 'Setup/Create Mongo Indexes'
  task :mongo_index do
    # system 'rake db:mongoid:create_indexes'
    system 'rake db:create_indexes'
  end

end