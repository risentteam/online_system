class ChanfeRequistion < ActiveRecord::Migration
  def change
  	remove_column :requistions, :contract
  	remove_column :requistions, :buildings_id
  	remove_column :requistions, :category
  	add_column :requistions, :subtype_requistions, :string
  end
end
