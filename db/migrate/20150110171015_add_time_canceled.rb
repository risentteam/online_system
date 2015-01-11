class AddTimeCanceled < ActiveRecord::Migration
  def change
  	add_column :requistions, :time_canceled, :datetime
  	add_column :requistions, :who_cancel, :integer
  end
end
