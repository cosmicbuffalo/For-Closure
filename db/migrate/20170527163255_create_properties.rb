class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.integer :addresss
      t.string :street
      t.string :prefix
      t.integer :zip_code
      t.string :city
      t.string :state
      t.integer :bedroom
      t.integer :bathroom
      t.integer :price
      t.string :type
      t.string :unit_num

      t.timestamps null: false
    end
  end
end
