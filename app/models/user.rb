class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i
  
  validates :username, presence: true, length: { minimum: 8 }
  validates :email, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, format: { with: VALID_PASSWORD_REGEX }
  has_many :movies
end
