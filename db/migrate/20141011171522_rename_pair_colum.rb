class RenamePairColum < ActiveRecord::Migration
  def change
    rename_column :pairs, :id_requistion, :requistion_id
  end
end
