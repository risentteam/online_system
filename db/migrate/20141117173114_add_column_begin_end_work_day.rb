class AddColumnBeginEndWorkDay < ActiveRecord::Migration
  def change
  	add_column :arrivals, :begin_or_end, :integer
  end
end
