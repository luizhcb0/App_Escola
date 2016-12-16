class User < ApplicationRecord
  has_one :professor
  has_many :student_users
  has_many :students, through: :student_users
  belongs_to :role

  has_secure_password
  # there must be a password on create
  validates :password, presence: true, on: :create
  validates :name, :email, :role, presence: true
  validates :email, uniqueness: true


  # Sets the user role with the specified role name. If doesn't find it the
  # correspondent role in the database, creates a new one and sets with it.
  def with_role(role_name)
    self.role = Role.where(name: role_name).first_or_create
    self # returns the user
  end
end
