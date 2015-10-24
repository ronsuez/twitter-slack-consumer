class AddStatesToListChannel < ActiveRecord::Migration
  def change
    add_column :list_channels, :created_in_slack, :boolean , default: false
    add_column :list_channels, :is_active, :boolean, default: false
  end
end
