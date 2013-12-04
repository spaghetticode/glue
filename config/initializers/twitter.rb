require 'twitter'

config = Rails.root.join('config/twitter.yml')
dummy  = Rails.root.join('config/twitter.yml.sample')
config_file = config.exist? ? config : dummy

TWITTER = YAML.load_file config_file

Twitter.configure do |config|
  config.consumer_key       = TWITTER['key']
  config.consumer_secret    = TWITTER['secret']
  config.oauth_token        = TWITTER['oauth_token']
  config.oauth_token_secret = TWITTER['oauth_secret']
end