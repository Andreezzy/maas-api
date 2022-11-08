class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  validates :last_name, presence: true
  validates :avatar, presence: true
  validates :color, presence: true, length: { is: 7 }
  validates :password, length: { minimum: 8 }, if: -> { new_record? }
  validates :password_confirmation, presence: true, if: -> { new_record? }
end
