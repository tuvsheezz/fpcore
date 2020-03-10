class Branch < ApplicationRecord
	has_many :products
	has_many :sales
	has_many :debts
	validates :name, presence: {message: 'хоосон байж болохгүй' }
	validates :name, uniqueness: {message: 'давхцаж байна. Өөр нэр сонгоно уу.' }
  has_one_attached :image
end
