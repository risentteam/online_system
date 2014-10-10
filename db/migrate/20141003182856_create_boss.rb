class CreateBoss < ActiveRecord::Migration
  def change
    create_table "bosses", force: true do |t|
      t.string "name"
    end
  end
end
