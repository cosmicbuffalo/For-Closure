class AddDisplayToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :display, :string
  end
end
