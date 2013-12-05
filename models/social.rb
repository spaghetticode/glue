require 'yaml'
require 'twitter'

file = File.expand_path('../../config/twitter.yml', __FILE__)
yml  = YAML.load_file file

Twitter.configure do |config|
  config.consumer_key       = yml['key']
  config.consumer_secret    = yml['secret']
  config.oauth_token        = yml['oauth_token']
  config.oauth_token_secret = yml['oauth_secret']
end

module Social
  extend self

  def tweet(message)
    begin
      Twitter.update message
    rescue => e
      puts "TWITTER ERROR: #{e.message}"
      puts e.backtrace
    end
  end
end