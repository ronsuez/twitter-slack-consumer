ActiveAdmin.register SlackChannel do
	config.per_page = 5
	permit_params :full_name, :name, :description, :slack_channel_id, :is_active, :connect_to_list
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
	
	# form do |f|
	# 	inputs 'Detail' do
	# 		input :full_name
	# 		input :name
	# 		input :description
	# 		input :slack_channel_id
	# 		input :is_active
	# 		input :created_in_slack
	# 		actions
	# 	end
	# end
	


	# member_action :sync, method: :get do
 #    resource.sync!
 #    redirect_to resource_path, notice: "Synced with Twitter!"
  #end
end
