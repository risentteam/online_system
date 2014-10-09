class AddColumnType < ActiveRecord::Migration
  def change
    add_column :requistions, :type, :int
  end
end
