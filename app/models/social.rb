class Social
  def tweet(message)
    begin
      Twitter.update message
    rescue => e
      puts "TWITTER ERROR #{e.message}"
      puts e.backtrace
    end
  end
end