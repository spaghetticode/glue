require 'yaml'
require 'twitter'

file = File.expand_path('../../config/twitter.yml', __FILE__)
conf = File.file?(file) ? YAML.load_file(file) : {}

Twitter.configure do |config|
  config.consumer_key       = conf['key']
  config.consumer_secret    = conf['secret']
  config.oauth_token        = conf['oauth_token']
  config.oauth_token_secret = conf['oauth_secret']
end


module Social
  extend self

  def tweet(message)
    return unless twitter_enabled?
    begin
      Twitter.update message
    rescue => e
      puts "TWITTER ERROR: #{e.message}"
      puts e.backtrace
    end
  end

  def twitter_enabled?
    Twitter.consumer_key.present?
  end
end