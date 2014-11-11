class ChangeRequistionStatus < ActiveRecord::Migration
  def change
  	change_table :requistions do |t|
      t.change :status, :integer, default: 0
    end
  end
end
