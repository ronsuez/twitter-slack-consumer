class CreateSlackChannels < ActiveRecord::Migration
  def change
    create_table :slack_channels do |t|
      t.string :name
      t.string :topic
      t.string :creator
      t.string :purpose
      t.string :group_id
      t.boolean :connect_to_list

      t.timestamps null: false
    end
  end
end
