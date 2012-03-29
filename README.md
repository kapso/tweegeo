# Tweegeo

This is the Tweegeo application. Here's what it does - 

Uses the Twitter Streaming API (https://dev.twitter.com/docs/streaming-api) to get location tagged tweets between NYC and SFO and saves the tweets to MongoDB. These tweets are then displayed on the client based on location input by the user.

### Setup

Installing/Starting MongoDB:

    $ brew update
    $ brew install mongodb
    $ sudo mkdir -p /data/db/
    $ sudo chown `id -u` /data/db
    $ mongod &

App Setup:

    $ git clone git@github.com:kapso/tweegeo.git
    $ cd tweegeo
    $ rvm gemset create tweegeo
    $ gem install bundler
    $ bundle install
    $ rake db:drop && rake db:create && rake db:create_indexes && rake db:seed
    $ rails s

Startup the process to Stream Tweets (fire up a separate shell for this):

    $ export TWITTER_PWD=xxxxxx
    $ rake app:fetch_tweets

### Deployment

The application is Heroku enabled. See `Procfile` and `config/mongoid.yml` for details.