class AddHomeTypeToProperties < ActiveRecord::Migration
  def change
    add_reference :properties, :home_type, index: true, foreign_key: true
  end
end
