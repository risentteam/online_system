class RenameTablePairNew < ActiveRecord::Migration
  def change
    rename_table :pair_user_requistions, :pairs
  end
end
