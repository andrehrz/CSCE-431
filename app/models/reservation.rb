class Reservation < ApplicationRecord
    # Establist relationship
    belongs_to :account
    has_one :equipment
end
