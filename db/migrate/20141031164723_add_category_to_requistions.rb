class AddCategoryToRequistions < ActiveRecord::Migration
  def change
  	add_column :requistions, :category, :integer
  end
end
