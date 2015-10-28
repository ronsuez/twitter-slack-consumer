ActiveAdmin.register ListChannel do
	config.per_page = 10
	config.sort_order = 'created_in_slack_desc'
	permit_params :full_name, :name, :description, :slack_channel_id, :is_active, :created_in_slack
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
	
	filter :is_active
	filter :created_in_slack
	filter :name
	filter :slug
	filter :slack_channel_id, as: :select , collection: -> {SlackChannel.all.map{ |c| [c.name, c.group_id]}}

	index do
		column :name #,sortable :name
		column :created_in_slack #, sortable :created_in_slack
		column :slack_channel_id #, sortable :slack_channel_id
		column :slug #, sortable :slug
		actions
	end
	
	form do |f|
		inputs 'Detail' do
			input :full_name
			input :name
			input :description
			input :slack_channel_id,  :as => :select , :collection => SlackChannel.all.map{ |c| [c.name, c.group_id]}
			input :is_active
			input :created_in_slack
			actions
		end
	end
	


	member_action :sync, method: :get do
    resource.sync!
    redirect_to resource_path, notice: "Synced with Twitter!"
  end
end
