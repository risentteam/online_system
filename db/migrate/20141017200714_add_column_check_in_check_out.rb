class AddColumnCheckInCheckOut < ActiveRecord::Migration
  def change
  	 add_column :pairs, :check_in, :datetime
  	 add_column :pairs, :check_out, :datetime
  end
end
