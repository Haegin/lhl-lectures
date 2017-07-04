class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :comments

  validates :title, presence: true, length: { maximum: 100 }
end
