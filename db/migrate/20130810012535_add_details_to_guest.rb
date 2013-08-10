class AddDetailsToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :wedding, :boolean
    add_column :guests, :bus, :boolean
    add_column :guests, :brunch, :boolean
  end
end
