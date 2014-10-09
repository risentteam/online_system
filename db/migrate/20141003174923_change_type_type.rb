class ChangeTypeType < ActiveRecord::Migration
  def change
    change_column :requistions, :type, :char
  end
end
