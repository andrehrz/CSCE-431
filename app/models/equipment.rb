class Equipment < ApplicationRecord

    # Establish Relationship
    belongs_to :reservation, optional: true

    # Scope Testing of Account Model
    scope :avail_items, -> { where(available: true) }
    scope :not_avail_items, -> { where(available: false) }

    # Validation Testing of Account Model
    validates :name, presence: true
    validates :description, presence: true
    # validates :available, presence: true
    validates :available, inclusion: [true, false] 

end
