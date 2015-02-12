class AddUserInfo < ActiveRecord::Migration
  def change
  	add_column :users, :region, :string
  	add_column :users, :specialization, :string
  end
end
