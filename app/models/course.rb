class Course < ApplicationRecord
  validates :title, :language, presence: true
  validates :description, presence: true, length: { :minimum => 10 }
  validates :short_description, presence: true, length: { :minimum => 5 }
  validates :price, presence: true, numericality: { only_integer: true }

  belongs_to :user
  has_many :lessons, dependent: :destroy

  def to_s
    title
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "short_description", "id", "language", "price", "title", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  has_rich_text :description

  extend FriendlyId
  friendly_id :title, use: :slugged

  LANGUAGES = [:"English", :"Filipino", :"Cebuano"]
  def self.languages
    LANGUAGES.map{ |language| [language, language]}
  end

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

end
