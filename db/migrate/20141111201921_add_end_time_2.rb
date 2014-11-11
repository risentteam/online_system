class AddEndTime2 < ActiveRecord::Migration
  def change
  	  add_column :contracts, :end_time, :datetime
  	  add_column :contracts, :begin_time, :datetime  	
  end
end
