class AddDedlineTime < ActiveRecord::Migration
  def change
  	add_column :requistions, :time_deadline, :datetime
  end
end
