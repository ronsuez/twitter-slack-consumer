class SyncSlackWithTwitter
	
	@queue = :jobs
	
	def self.perform
		puts "Syncing channels"
		 %x(bundle exec rake slack:post_to_channel)
		end 
	end

