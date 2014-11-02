class Add < ActiveRecord::Migration
  def change
  	add_column :requistions, :comment, :string
  end
end
