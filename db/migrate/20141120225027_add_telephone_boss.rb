class AddTelephoneBoss < ActiveRecord::Migration
  def change
  	add_column :boss, :telephone, :string
  end
end
