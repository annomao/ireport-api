class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.string :title
      t.string :location
      t.string :comment
      t.integer :user_id
      t.integer :type_id
      t.timestamps
    end
  end
end
