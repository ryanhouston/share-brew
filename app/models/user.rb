require 'validators/email_format_validator'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :recipes

  validates :email, presence: true, uniqueness: true, email_format: true
  validates :name, presence: true, length: { maximum: 255 }
end
