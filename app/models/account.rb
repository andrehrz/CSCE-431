class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Relationships
  has_many :reservations
  has_many :equipments, through: :reservations

  # Scope Testing of Account Model
  scope :admin_accounts, -> { where(is_admin: true) }
  scope :member_accounts, -> { where(is_admin: false) }

  # Validation Testing of Account Model
  validates :email, presence: true
  # validates :password, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :secondary_contact, presence: true
  # validates :is_admin, presence: true
end
