class Course < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true, length: { :minimum => 10 }
  validates :short_description, presence: true, length: { :minimum => 5 }
  validates :language, presence: true
  validates :price, presence: true, numericality: { only_integer: true }

  belongs_to :user
  
  def to_s
    title
  end
  
  has_rich_text :description

  extend FriendlyId
  friendly_id :title, use: :slugged
end
