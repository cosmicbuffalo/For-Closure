class Property < ActiveRecord::Base
  belongs_to :user
<<<<<<< HEAD
  belongs_to :home_type
  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
=======
  # belongs_to :home_type, through: :category
>>>>>>> fa1f1112ba6b253ff4c906536cceb421734706b6

  # validates :address, presence: :true, uniqueness: { case_sensitive: false }
  # validates :price, presence: :true
  # validates :description, length: { minimum: 1 }

  # before_validation :downcase_address

  # def downcase_address
  #   self.address.downcase!
  # end

  has_many :owners , class_name: 'User'
  geocoded_by :address
  after_validation :geocode
  acts_as_mappable :lat_column_name => :latitude, :lng_column_name => :longitude

end
