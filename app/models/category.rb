class Category < ActiveRecord::Base
  belongs_to :property
  belongs_to :hometype
end
