class Property < ActiveRecord::Base
  belongs_to :user
  belongs_to :home_type
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_many :images, as: :imageable
  accepts_nested_attributes_for :images
  # has_many :owners , class_name: 'User'

  validates :address, presence: :true, uniqueness: { case_sensitive: false }
  validates :price, presence: :true
  # validates :description, length: { minimum: 1 }

  # before_validation :downcase_address

  # def downcase_address
  #   self.address.downcase!
  # end

  geocoded_by :address
  after_validation :geocode
  acts_as_mappable :lat_column_name => :latitude, :lng_column_name => :longitude



  def get_category_details(category_group)
    categories = self.categories.where("category like?", "#{category_group}%")
    unless categories.length == 0
      found = []
      categories.each do |category|
        found.push category.display
      end
      return found.join(', ')
    else
      return false
    end
  end


end
