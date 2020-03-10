class Role < ApplicationRecord
	has_many :users
	validates :en, presence: true
	validates :mn, presence: true
	validates :en, uniqueness: true
	validates :mn, uniqueness: true

end
