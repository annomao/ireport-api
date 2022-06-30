class AddReportsStatusColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :status, :string
  end
end
