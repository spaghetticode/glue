require 'twitter'

TWITTER = YAML.load_file Rails.root.join('config/twitter.yml')

Twitter.configure do |config|
  config.consumer_key       = TWITTER['key']
  config.consumer_secret    = TWITTER['secret']
  config.oauth_token        = TWITTER['oauth_token']
  config.oauth_token_secret = TWITTER['oauth_secret']
end