namespace :twitter do
	desc "Retrieve lists"
	task :get_lists_from_twitter => :environment do
		client_lists = $twitter_client.owned_lists()

		client_lists.each do |list|
				puts "#{list.id.to_s} #{list.name}"
		end
	end

	desc "Sync lists with DB"
	task :sync_lists => :environment do

		client_lists = $twitter_client.owned_lists()

		client_lists.each do |list|
				channel = ListChannel.where(twitter_list_id: list.id).first rescue nil
         
					if channel.blank?
						puts "Creating a new #{list.name} instance"
						channel = ListChannel.new
					end
        
					channel.twitter_list_id = list.id
					channel.name = list.name
					channel.full_name = list.full_name
					channel.uri = list.uri
					channel.slug = list.slug
					channel.description = list.description
					channel.member_count = list.member_count
					channel.subscriber_count = list.subscriber_count
					channel.list_mode = list.mode
					channel.save

					puts "Channel #{channel.full_name} saved"

		end

	end

	desc "Create Slack Groups per Twitter lists"
	task :create_groups => :environment do
		
		slackhub = $slack_client.auth_test
		slackhub_user = slackhub['user']

  	puts "=> Connected? #{slackhub['ok']}"
  	puts "=> Team? #{slackhub['team']}"
  	puts "=> User? #{slackhub['user']}"
  	puts "=> url? #{slackhub['url']}"

  	puts "=> Retrieving Groups associated with #{slackhub['user']}"

   list = ListChannel.where(slack_channel_id: nil).first

   puts list
   #lists.each do |list|
 		group = $slack_client.groups_create(name: list.name)

 
 		if group['ok']
					puts "Creating a new #{list.name} instance"
					group = SlackChannel.new
		else
			exit 0
		end
      
		group.name =  group['group']['name']
		group.group_id = group['group']['id']
		group.save

		list.slack_channel_id = group['group']['id']
		list.save
   #end
	end
end
