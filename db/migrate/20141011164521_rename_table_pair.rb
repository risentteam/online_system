class RenameTablePair < ActiveRecord::Migration
  def change
    rename_table :pair_worker_requistions, :pair_user_requistions
  end
end
