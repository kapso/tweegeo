require 'twitter/json_stream'

module Worker::TwitterStream

  # doing basic auth here for now, though oauth is advised
  TwitterUser = Settings.twitter.user
  TwitterPwd  = Settings.twitter.password

  # bounding box covers SFO <--> NYC
  Query       = 'locations=-122.75,36.8,-121.75,37.8,-74,40,-73,41' 

  class << self

    def start
      log_stdout 'Starting to fetch tweets'

      EM::run do

        stream = Twitter::JSONStream.connect(
          ssl:     true,
          auth:    "#{TwitterUser}:#{TwitterPwd}",
          path:    '/1/statuses/filter.json',
          method:  'POST',
          content: Query
        )

        stream.each_item do |item|
          save_tweet item if item
        end
        
        stream.on_error do |message|
          log_stdout "Error: #{message}"
        end
        
        stream.on_reconnect do |timeout, retries|
          msg = "Cannot connect, #{retries} attempt(s). Reconnecting in: #{timeout} seconds"
          log_stdout msg
        end
        
        stream.on_max_reconnects do |timeout, retries|
          log_stdout "Failed after #{retries} failed reconnects"
        end
    
        trap 'TERM' do  
          stream.stop
          em_die_gracefully
        end

        trap 'INT' do  
          stream.stop
          em_die_gracefully
        end
      end

      log_stdout 'TwitterStream EM loop has ended, final bye!'
    end

    private

      def save_tweet (item)
        status = Crack::JSON.parse(item)
        Tweet.create_from_status!(status) if status.is_a?(Hash) && status.size > 0
        item = status = nil
      rescue => ex
        log_stdout "Error: Parsing or Saving tweet - #{ex.message}"
        # suck up this exception and move on
      end

      def em_die_gracefully
        log_stdout 'Shutting down EM gracefully, bye!'
        EM.stop if EM.reactor_running?
      end

      def log_stdout (msg)
        $stdout.print "Tweegeo TwitterStream Client ==> #{msg}\n"
        $stdout.flush
      end

  end

end