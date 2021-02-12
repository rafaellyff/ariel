class Hormone < ApplicationRecord
  belongs_to :molecule
  belongs_to :user
  
  validates_presence_of :name, :molecule_id, :periodicity, :unit, :unit_per_dose, :user_id
  validates :periodicity, numericality: { greater_than_or_equal_to: 1, only_integer: true }

  enum unit: {
    ampoule: 'ampoule',
    pill: 'pill',
    milligram: 'milligram',
    millilitre: 'millilitre',
    ounce: 'ounce',
    patch: 'patch',
    pump: 'pump',
    sachet: 'sachet',
    other: 'other'
  }
end
