class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :address
      t.integer :bedroom
      t.float :bathroom
      t.integer :zipcode
      t.decimal :price
      t.string :unit
      t.boolean :rent
      t.text :description
      t.float :longitude
      t.float :latitude
      t.references :user, index: true, foreign_key: true
      t.references :home_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
