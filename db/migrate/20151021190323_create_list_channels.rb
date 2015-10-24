class CreateListChannels < ActiveRecord::Migration
  def change
    create_table :list_channels do |t|
      t.string :name
      t.string :slack_channel_id
      t.integer :twitter_list_id

      t.timestamps null: false
    end
  end
end
