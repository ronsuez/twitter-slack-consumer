namespace :slack do |args|

	desc "Retrieve channels from Slack"
	task :get_channels => :environment do
		 
		channels = $slack_client.channels_list['channels']

		channels.each do |c|
			puts "#{c['id']} #{c['name']}: #{c['purpose']['value']} "
		end
	end
  
  desc "Retrieve group from Slack"
  task :get_groups => :environment do
  	groups = $slack_client.groups_list['groups']
  	

  	if groups.count > 0 
			groups.each do |c|
				puts "#{c['id']} #{c['name']}: #{c['purpose']['value']} #{c['topic']['value']} #{c['creator']} "
			end
  	else
  		puts "The bot is not in any group"
  	end
  end

  desc "Sync Groups from Slack"
  task :sync_groups => :environment do
  	
  	slackhub = $slack_client.auth_test

  	puts "=> Connected? #{slackhub['ok']}"
  	puts "=> Team? #{slackhub['team']}"
  	puts "=> User? #{slackhub['user']}"
  	puts "=> url? #{slackhub['url']}"

  	puts "=> Retrieving Groups associated with #{slackhub['user']}"

  	groups = $slack_client.groups_list['groups']
  	
  	if( groups.count > 0)
  		groups.each do |given_group|

				group = SlackChannel.where(group_id: given_group['id']).first rescue nil
         
					if group.blank?
						puts "Creating a new #{given_group['name']} instance"
						group = SlackChannel.new
						puts "Saving Group #{group.name}"	
					end

					group.name = given_group['name']
					group.purpose = given_group['purpose']['value']
					group.topic = given_group['topic']['value']
					group.creator = given_group['creator']
					group.group_id = given_group['id']
					group.connect_to_list = false
					group.save
					puts "Group #{group.name} updated"	
			end
  	end
		
  end

	desc "fetch tweets from an user list and send it to Slack Private Channel"
	task :post_to_channels => :environment do 

		options = {}
    OptionParser.new(args) do |opts|
      opts.banner = "Usage: rake slack:post_to_channels [options]"
      opts.on("-l", "--list_name {twitter_list_name}","List's name", String) do |list_name|
        options[:list_name] = list_name
      end
      opts.on("-c", "--channel_name {channel_name}","Channel's name", String) do |channel_name|
        options[:channel_name] = channel_name
      end
    end.parse!


		lc = ListChannel.find_by(name: options[:list_name])
    	
    if lc.nil?
    	puts "No channel #{options[:list_name]} found"
    	exit 0
    end
    
    puts "Fetching tweets from : #{options[:list_name]}"

    timeline = $twitter_client.list_timeline(lc.twitter_list_id)
		given_group = $slack_client.groups_list['groups'].detect {|g| g['name'] == options[:channel_name]}

		puts "fetched #{timeline.count} tweets"


		timeline.each do |tweet|
				puts "posting tweet from #{tweet.user.screen_name}"
				a = "[{\"pretext\": \"https://twitter.com/statuses/#{tweet.id}\", \"color\": \"#439FE0\"}]"
				m = $slack_client.chat_postMessage(channel: given_group['id'], text: tweet.text,  attachments: a, as_user: true)
				
		end

		puts "posted #{timeline.count} messages"
		exit 0
	end

	desc "fetch tweets from an user list and send it to Slack Private Channel"
	task :post_to_channel => :environment do 
		#Resque task
		lc = ListChannel.where(created_in_slack: true, is_active: true)
 		if (lc.count  > 0 )
		    lc.each do |l|
		    	Resque.enqueue(PostToSlack, l.name, l.twitter_list_id, l.slack_channel_id)	
		    end
		end
		exit 0
	end
end