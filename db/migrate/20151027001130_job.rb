class Job < ActiveRecord::Migration
  def change_job
  	create_table :jobs do |t|
      t.text :title
      t.text :description
      t.text :location
      t.timestamps null: false
    end
  end
end
