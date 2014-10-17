class Deleteworker < ActiveRecord::Migration
  def change
  	drop_table :workers
  end
end
