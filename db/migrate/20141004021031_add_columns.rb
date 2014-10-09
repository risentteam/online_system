class AddColumns < ActiveRecord::Migration
  def change
    add_column :requistions, :company, :string
    add_column :requistions, :contract, :string
    add_column :requistions, :contract_period, :datetime
    add_column :requistions, :category, :integer
  end
end
