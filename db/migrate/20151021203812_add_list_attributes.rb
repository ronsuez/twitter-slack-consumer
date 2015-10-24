class AddListAttributes < ActiveRecord::Migration
  def change
  	 add_column :list_channels, :uri, :string
     add_column :list_channels, :slug, :string
  	 add_column :list_channels, :full_name, :string
     add_column :list_channels, :list_mode, :string
  	 add_column :list_channels, :description, :string
  	 add_column :list_channels, :member_count, :integer
     add_column :list_channels, :subscriber_count, :integer
  end
end
