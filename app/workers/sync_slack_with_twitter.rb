require 'rake'  

class SyncSlackWithTwitter
	
	@queue = :jobs
	
	def self.perform
		puts "Syncing channels"
		Rake::Task['slack:post_to_channel'].invoke()
		rescue Exception => e
			puts e
		end 
	end

