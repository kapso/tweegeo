class Tweet

  include Mongoid::Document

  PerPage = 50

  store_in :tweets, capped: true, max: 100000, size: (100000 * 500)

  field :tweet_id, type: String
  field :text, type: String
  field :user_handle, type: String
  field :user_avatar_url, type: String
  field :place_name, type: String
  field :time, type: DateTime
  field :location, type: Array

  index [[ :location, Mongo::GEO2D ]], min: -200, max: 200, background: true

  # create index, since we doing a uniqueness check on tweet_id
  index :tweet_id, unique: true
  
  validates :tweet_id, :text, :user_handle, :location, :time, :user_avatar_url, presence: true
  validates_uniqueness_of :tweet_id
  validates_format_of :user_avatar_url, with: /\A^https?:\/\/\S+\z/

  scope :latest, order_by([:time, :desc])
  scope :page, ->(pg, limit = PerPage) { skip((pg - 1) * limit).limit(limit) }

  class << self

    def latest_by_location (geolong, geolat)
      near(location: [geolong, geolat]).latest
    end

    ##
    # Create a tweet in the collection from standard twitter status
    # See - https://dev.twitter.com/docs/api/1/get/statuses/show/%3Aid
    #
    def create_from_status! (status)
      # Create a document only if geocords are available
      # TODO: relook this logic later, other options available
      if status['geo'] && status['geo']['type'] == 'Point'
        tweet = new do |t|
          t.tweet_id = status['id_str']
          t.text = status['text']
          t.user_handle = status['user']['screen_name']
          t.user_avatar_url = status['user']['profile_image_url']
          t.location = status['geo']['coordinates'] # returns [-77.423456, 42.989259]
          t.place_name = status['place']['full_name'] if status['place']
          t.time = Time.parse(status['created_at']) # returns "Wed Mar 28 21:28:55 +0000 2012"
        end
        tweet.save!
        tweet
      end
    end

  end

end