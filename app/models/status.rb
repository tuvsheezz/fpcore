class Status < ApplicationRecord
	has_many :items
	validates :en, presence: true
	validates :mn, presence: true
	validates :en, uniqueness: true
	validates :mn, uniqueness: true
end
