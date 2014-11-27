class CreateTableMainAddress < ActiveRecord::Migration
  def change
    create_table :table_main_addresses do |t|
      t.string   "name"
    end
  end
end
