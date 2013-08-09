class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name
      t.integer :user_id
      t.string :diet

      t.timestamps
    end
    add_index :guests, [:user_id, :created_at]
  end
end
