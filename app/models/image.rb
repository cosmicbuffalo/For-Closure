class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  has_attached_file :image, styles: lambda {
    |attachment| {
      thumb: (
        attachment.instance.imageable_type.eql?("Property")? ["300>", 'jpg'] :  ["200>", 'jpg']
      ),
      medium: (
       ["500>", 'jpg']
      )
    }
  }

end
