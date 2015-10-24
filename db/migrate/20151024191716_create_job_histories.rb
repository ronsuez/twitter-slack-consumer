class CreateJobHistories < ActiveRecord::Migration
  def change
    create_table :job_histories do |t|
    	t.string :list_name
    	t.string :channel_name
    	
      t.timestamps null: false
    end
  end
end
