class Box < ApplicationRecord
  belongs_to :hormone

  validates_presence_of :amount, :expiration_date, :hormone_id
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  
  before_create do
    self.remaining_amount = amount
  end
end
