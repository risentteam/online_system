class RenameColmnTime < ActiveRecord::Migration
  def change
  	rename_column :arrivals, :time, :date
  end
end
