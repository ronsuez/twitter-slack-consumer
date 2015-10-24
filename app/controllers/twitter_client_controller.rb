class TwitterClientController < ApplicationController

	
	def user_timeline
		c = $twitter_client.home_timeline()

		respond_to do |format|
  		format.html # show.html.erb
  		format.json { render json: c }
 		end
		
	end

	def lists_subscriptions
		
		client_lists = $twitter_client.subscriptions()

		respond_to do |format|
  		format.html # show.html.erb
  		format.json { render json: client_lists }
 		end
	end
	
	def lists
		client_lists = $twitter_client.owned_lists()
		
		respond_to do |format|
  		format.html # show.html.erb
  		format.json { render json: client_lists }
 		end
	end

	def lists_detail
		c = $twitter_client.list_timeline(params[:id].to_i)
		respond_to do |format|
  		format.html # show.html.erb
  		format.json { render json: c }
 		end
	end
end
