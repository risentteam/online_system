class AddColumnWho < ActiveRecord::Migration
  def change
  	add_column :requistions, :who_created, :integer
  	add_column :requistions, :who_assigned, :integer
  	add_column :requistions, :who_adopted, :integer
  	add_column :requistions, :who_done, :integer
  	add_column :requistions, :who_comleted, :integer  	
  end
end
