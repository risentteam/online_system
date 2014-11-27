class RenamePairColum2 < ActiveRecord::Migration
  def change
    rename_column :pairs, :id_worker, :id_user
  end
end
