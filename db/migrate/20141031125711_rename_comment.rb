class RenameComment < ActiveRecord::Migration
  def change
  	rename_column :requistions, :comment, :requistion_comment
  end
end
