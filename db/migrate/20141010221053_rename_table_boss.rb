class RenameTableBoss < ActiveRecord::Migration
  def change
    rename_table :boss, :bosses
  end
end
