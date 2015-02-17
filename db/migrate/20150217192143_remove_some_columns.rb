class RemoveSomeColumns < ActiveRecord::Migration
  def change
  	remove_columns :requistions, :main_address, :arrival_address, :object
  end
end
