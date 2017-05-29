class Property < ActiveRecord::Base
  belongs_to :user
  belongs_to :home_type, through: :category

  validates :address, presence: :true, uniqueness: { case_sensitive: false }
  validates :price, presence: :true
  validates :description, length: { minimum: 1 }

  # before_validation :downcase_address

  # def downcase_address
  #   self.address.downcase!
  # end

  has_many :owners , class_name: 'User'
  geocoded_by :address
  after_validation :geocode

end
