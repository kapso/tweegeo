rails_env = ENV['RAILS_ENV'] || 'production'

worker_processes 3 # amount of unicorn workers to spin up
timeout 30         # restarts workers that hang for 30 seconds

# Mongoid advises not to use preload_app 
# - http://mongoid.org/docs/upgrading.html
# - http://mongoid.org/docs/rails/railties.html
# preload_app true

GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true

before_fork do |server, worker|
  # defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  # defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
  
  # for memcached/DalliStore, to reset/reconnect connection
  Rails.cache.reset
end