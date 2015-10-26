if $twitter_client.nil?

	$twitter_client = Twitter::REST::Client.new do |config|
	  config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
	  config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
	  config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
	  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
	end

	#client.update("I'm tweeting with @gem!")
	puts "=> Twitter Client configured"

end