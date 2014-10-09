class AddColumnInfo < ActiveRecord::Migration
  def change
    add_column :requistions, :info, :string
  end
end
