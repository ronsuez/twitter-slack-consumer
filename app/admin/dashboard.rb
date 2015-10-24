ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }
   
  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Lists-Channels" do
          table_for ListChannel.order('id desc').limit(10).each do |channel|

            column(:name)    {|channel| channel.full_name }
            column(:created_in_slack?)    {|channel| channel.created_in_slack}
            column(:is_active?)    {|channel| channel.is_active}
            column(:link)    {|channel| link_to(channel.full_name, admin_list_channel_path(channel)) }
          end
        end
      end

      column do
        panel "Slack-Channels" do
            table_for SlackChannel.order('id desc').limit(10).each do |channel|
                column(:name)    {|channel| channel.name }
                column(:topic)    {|channel| channel.topic}
                column(:creator)    {|channel| channel.creator}
                column(:group_id)    {|channel| channel.group_id}
                column(:connect_to_list)    {|channel| channel.connect_to_list}
                 
            end
        end
      end
    end
  end # content
end
