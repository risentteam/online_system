class AddContract < ActiveRecord::Migration
  def change
  	add_column :requistions, :contract, :integer
  end
end
