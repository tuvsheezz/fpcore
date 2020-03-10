class Subcategory < ApplicationRecord
	belongs_to :category
	has_many :items
  has_one_attached :image
	validates :name, presence: {message: 'хоосон байж болохгүй' }
	validates :name, uniqueness: {message: 'давхцаж байна. Өөр нэр сонгоно уу.' }
end
