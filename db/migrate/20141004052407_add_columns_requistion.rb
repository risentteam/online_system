class AddColumnsRequistion < ActiveRecord::Migration
  def change
    add_column :workers, :requistion_id, :integer
  end
end
