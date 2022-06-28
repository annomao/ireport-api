class ChangeTypeColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :types, :CreateTypes, :name
  end
end
