class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable

  def to_s
    email
  end

  def self.ransackable_attributes(auth_object = nil)
    ["confirmed_at", "created_at", "current_sign_in_at", "current_sign_in_ip", "email", "id", "last_sign_in_at", "last_sign_in_ip", "remember_created_at", "reset_password_sent_at", "reset_password_token", "sign_in_count", "unconfirmed_email", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["courses"]
  end
 
  has_many :courses
end
