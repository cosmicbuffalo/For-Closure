class Property < ActiveRecord::Base
  belongs_to :user
  belongs_to :type

  has_many :owners , class_name: 'User'
  geocoded_by :address
  after_validation :geocode
end
