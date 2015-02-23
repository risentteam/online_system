class SetDefaultObjectName < ActiveRecord::Migration
  def change
  	change_column_default :buildings, :name, "Не указано"
  end
end
