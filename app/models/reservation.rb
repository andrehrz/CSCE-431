class Reservation < ApplicationRecord
  # Establish relationship
  belongs_to :account, optional: true
  has_one :equipment

  # Scope Testing of Reservation Model
  # Not Implemented Yet

  # Validation Testing of Reservation Model
  validates :account_id, presence: true # Was commented out
  # validates :future_equip_id, presence: true
  validates :checkout_date, presence: true # Was commented out
  validates :checkin_date, presence: true # Was commented out
  # validates :event_description, presence: true
end
