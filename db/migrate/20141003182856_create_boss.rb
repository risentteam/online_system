class ChangeType < ActiveRecord::Migration
  def change
    create_table "boss", force: true do |t|
      t.string "name"
    end
  end
end
