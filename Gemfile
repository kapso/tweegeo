source 'https://rubygems.org'

gem 'rails', '3.2.2'

gem 'bson_ext'
gem 'crack'
gem 'eventmachine'
gem 'jquery-rails'
gem 'mongoid'
gem 'rails_config'
gem 'rdiscount'
gem 'slim'
gem 'twitter-stream'

group :production, :staging do
  gem 'unicorn'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'uglifier', '>= 1.0.3'
end

gem 'rspec-rails', group: [:test, :development]

group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  # gem 'shoulda'
end