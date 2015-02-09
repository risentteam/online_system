class AddColumnWhoRunning < ActiveRecord::Migration
  def change
  	add_column :requistions, :who_running, :integer
  end
end
