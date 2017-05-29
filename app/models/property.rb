class Property < ActiveRecord::Base
  belongs_to :user
  belongs_to :home_type
  has_many :owners, class_name: 'User'
  has_many :pictures, as: :imageable, dependent: :destroy

  # validates :address, presence: :true, uniqueness: { case_sensitive: false }
  # validates :price, presence: :true
  # validates :description, length: { minimum: 1 }

  # before_validation :downcase_address

  # def downcase_address
  #   self.address.downcase!
  # end

end
