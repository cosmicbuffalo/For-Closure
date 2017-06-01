class User < ActiveRecord::Base
  has_secure_password
  
  has_many :favorites
  has_many :properties
  has_many :images, as: :imageable

  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  # EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  # validates :first_name, :last_name, presence: true, length: { in: 1..20 }
  # validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

  # before_validation :downcase_email

  # def downcase_email
  #   self.email.downcase!
  # end
end
