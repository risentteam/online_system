class MergeUserAndWorker < ActiveRecord::Migration
  def change
    add_column :users, :type, :integer
    add_column :users, :boss_id, :integer, default: 0 
  end
end
