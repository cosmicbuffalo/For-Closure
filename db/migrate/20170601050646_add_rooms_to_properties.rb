class AddRoomsToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :rooms, :integer
  end
end
