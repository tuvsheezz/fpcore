class Currency < ApplicationRecord
	has_many :items

	validates :name, presence: true
	validates :currency_name, presence: true
	validates :name, uniqueness: true
	validates :currency_name, uniqueness: true
end
