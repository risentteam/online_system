class RenamePairColum3 < ActiveRecord::Migration
  def change
    rename_column :pairs, :id_user, :user_id
  end
end
