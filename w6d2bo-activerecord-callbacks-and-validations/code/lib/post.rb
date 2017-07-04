class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :comments

  before_save :record_published_at_if_published

  validates :title, presence: true, length: { maximum: 100 }

  validate :enforce_the_first_rule

  scope :published, -> { where(published: true) }
  scope :published_before, -> (date) { where("published_at < ?", date) }

  private

  def record_published_at_if_published
    if published? && published_at.blank?
      self.published_at = DateTime.now
    end
  end

  def enforce_the_first_rule
    if title =~ /fight club/i
      errors.add :title, "can't talk about Fight Club"
    end
  end
end
