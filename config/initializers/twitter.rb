require 'twitter'

SOCIAL_CONFIG = YAML.load_file(Rails.root.join('config/social.yml')

Twitter.configure do |config|
  config.consumer_key       = SOCIAL_CONFIG['twitter_key']
  config.consumer_secret    = SOCIAL_CONFIG['twitter_secret']
  config.oauth_token        = SOCIAL_CONFIG['twitter_oauth_token']
  config.oauth_token_secret = SOCIAL_CONFIG['twitter_oauth_secret']
end