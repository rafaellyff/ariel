class Dose < ApplicationRecord
  belongs_to :hormone

  validates_presence_of :hormone_id, :amount, :expected_date, :status
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  enum status: {
    scheduled: 'scheduled',
    done: 'done',
    rescheduled: 'rescheduled'
  }

  enum apply_on: {
    left: 'left',
    right: 'right'
  }
end
