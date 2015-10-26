class AddGroupIdIndexToListChannel < ActiveRecord::Migration
  def change
  	add_index :slack_channels, :group_id, unique: true
  	add_foreign_key :list_channels, :slack_channels, column: :slack_channel_id , primary_key: "group_id"
  end
end
