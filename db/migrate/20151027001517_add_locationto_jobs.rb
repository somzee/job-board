class AddLocationtoJobs < ActiveRecord::Migration
  def change
  	add_column :jobs, :location, :text
  end
end
