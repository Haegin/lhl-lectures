require_relative "./email_validator"

class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :commented_posts, through: :comments, source: :post

  validates :name, :email, presence: true
  validates :email, uniqueness: true, email: true
end
