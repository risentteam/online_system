class AddTimeOfStatus < ActiveRecord::Migration
  def change
  	add_column :requistions, :time_assgned, :datetime
  	add_column :requistions, :time_adopted_in_work, :datetime
  	add_column :requistions, :time_running, :datetime
  	add_column :requistions, :time_done, :datetime
  	add_column :requistions, :time_comleted, :datetime
  end
end
