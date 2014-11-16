class AddRaiting < ActiveRecord::Migration
  def change
  	add_column :requistions, :raiting, :integer, default: 0
  end
end
