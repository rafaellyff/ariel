class Molecule < ApplicationRecord
  validates_presence_of :name
	validates_uniqueness_of :name
	
	before_save { self.name = self.name.titleize }
end
