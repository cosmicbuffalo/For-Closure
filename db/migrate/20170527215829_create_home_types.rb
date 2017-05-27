class CreateHomeTypes < ActiveRecord::Migration
  def change
    create_table :home_types do |t|
      t.string :type

      t.timestamps null: false
    end
  end
end
