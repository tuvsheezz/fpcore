class Salestatus < ApplicationRecord
	has_many :sales
	validates :en, presence: true
	validates :mn, presence: true
	validates :en, uniqueness: true
	validates :mn, uniqueness: true
end
