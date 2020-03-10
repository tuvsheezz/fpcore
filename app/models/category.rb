class Category < ApplicationRecord
	validates :name, presence: {message: 'Xоосон байж болохгүй' }
	validates :name, uniqueness: {message: 'Давхцаж байна. Өөр нэр сонгоно уу.' }
  has_one_attached :image
	has_many :subcategories, validate: false

	def category_name
		"#{name}"
	end
end
