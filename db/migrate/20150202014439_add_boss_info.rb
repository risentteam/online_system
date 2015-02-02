class AddBossInfo < ActiveRecord::Migration
  def change
  	add_column :bosses, :deputy, :string
  	add_column :bosses, :region, :string
  	add_column :bosses, :specialization, :string
  	add_column :bosses, :end_of_rest, :datetime
  	add_column :bosses, :begin_of_rest, :datetime
  end
end
