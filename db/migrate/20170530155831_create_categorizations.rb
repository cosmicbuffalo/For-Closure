class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.references :property, index: true, foreign_key: true
      t.references :category
      t.timestamps null: false
    end
  end
end
