class Box < ApplicationRecord
  belongs_to :hormone

  validates_presence_of :amount, :remaining_amount, :date_start, :expiration_date, :hormone_id
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :remaining_amount, numericality: { greater_than_or_equal_to: 0 }

  def calculate_remaining_amount(value)
    self.remaining_amount = self.remaining_amount - value
  end

end
