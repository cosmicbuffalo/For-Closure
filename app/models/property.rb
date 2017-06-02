class Property < ActiveRecord::Base
  belongs_to :user

 
 has_many :images, as: :imageable


  has_many :favorites
  has_many :users_that_favorited , through: :favorites, source: :user

#   has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }
#   validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  # belongs_to :home_type, through: :category
  belongs_to :home_type
  has_many :categorizations
  has_many :categories, through: :categorizations

  # has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }
  # validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  # belongs_to :home_type, through: :category


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

  def bedrooms

    beds = self.bedroom if self.bedroom

    return "Beds: #{beds}" if beds

    return false

  end



end
