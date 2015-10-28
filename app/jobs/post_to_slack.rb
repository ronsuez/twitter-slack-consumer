class PostToSlack
	
	@queue = :slack
	
	def self.perform(name, twitter_list_id, slack_channel_id)
		puts "Fetching tweets from : #{name}"
		puts "job process"
		timeline = $twitter_client.list_timeline(twitter_list_id)
		timeline.each do |tweet|
				a = "[{\"pretext\": \"https://twitter.com/statuses/#{tweet.id}\", \"color\": \"#439FE0\"}]"
				m = $slack_client.chat_postMessage(channel: slack_channel_id, text: tweet.text,  attachments: a, as_user: true, unfurl_links: true)		
		end 
	end

end

