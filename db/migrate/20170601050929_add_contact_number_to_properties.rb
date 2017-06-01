class AddContactNumberToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :contact_number, :string
  end
end
