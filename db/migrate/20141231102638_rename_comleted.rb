class RenameComleted < ActiveRecord::Migration
  def change
  	rename_column :requistions, :time_comleted, :time_completed
  end
end
