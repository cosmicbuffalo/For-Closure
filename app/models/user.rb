class User < ActiveRecord::Base
  has_secure_password
  
  has_many :favorites
  has_many :properties
  has_many :pictures, as: :imageable, dependent: :destroy

  # EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  # validates :first_name, :last_name, presence: true, length: { in: 1..20 }
  # validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

  # before_validation :downcase_email

  # def downcase_email
  #   self.email.downcase!
  # end
end
