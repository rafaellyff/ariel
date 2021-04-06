class Dose < ApplicationRecord
  belongs_to :hormone

  validates_presence_of :hormone_id, :scheduled_date

  before_create do
    self.amount = self.hormone.unit_per_dose
    self.status = 'scheduled'
  end

  enum status: {
    scheduled: 'scheduled',
    done: 'done',
    rescheduled: 'rescheduled'
  }

  enum apply_on: {
    left: 'left',
    right: 'right',
    indifferent: 'indifferent'
  }

end
