class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
    add_index :parties, [:user_id]
  end
end
