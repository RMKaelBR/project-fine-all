class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable

  def to_s
    email
  end

  def username
    self.email.split('@').first
  end

  def self.ransackable_attributes(auth_object = nil)
    ["confirmed_at", "created_at", "current_sign_in_at", "current_sign_in_ip", "email", "id", "last_sign_in_at", "last_sign_in_ip", "remember_created_at", "reset_password_sent_at", "reset_password_token", "sign_in_count", "unconfirmed_email", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["courses"]
  end
 
  has_many :courses

  after_create :assign_default_role

  def assign_default_role
    if User.count == 1
      self.add_role(:admin) if self.roles.blank?
      self.add_role(:teacher)
      self.add_role(:student)
    else
      self.add_role(:student) if self.roles.blank?
    end
  end

  validate :must_have_a_role, on: :update

  private
  def must_have_a_role
    puts "must_have_a_role validation called"
    unless roles.any?
      errors.add(:roles, "must have at least one role")
      puts "added some shit"
    end
  end
end
