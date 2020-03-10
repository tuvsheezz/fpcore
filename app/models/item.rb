class Item < ApplicationRecord
	belongs_to :subcategory
	belongs_to :currency
	has_many :products
	has_many :factoryreturns
	has_many :machigainaoshis
	belongs_to :status
	has_many :tasks, through: :products
	has_many :taks, through: :products
	has_many :trans, through: :transfers
	has_many :stoks, through: :stocks
	validates :name, presence: {message: 'хоосон байж болохгүй' }
	validates :name_mn, presence: {message: 'хоосон байж болохгүй' }
	validates :spec, presence: {message: 'хоосон байж болохгүй' }
	validates :name, uniqueness: {message: 'давхцаж байна. Өөр нэр сонгоно уу.' }
	validates :name_mn, uniqueness: {message: 'давхцаж байна. Өөр нэр сонгоно уу.' }
	validates :price, presence: {message: 'хоосон байж болохгүй' }
	validates :maxp, presence: {message: 'хоосон байж болохгүй' }
	validates :minp, presence: {message: 'хоосон байж болохгүй' }
	validates :minimum, presence: {message: 'хоосон байж болохгүй' }
	#validates :bar, presence: {message: 'хоосон байж болохгүй'}, uniqueness: {message: 'давхцаж байна. Бар код сонгоно уу.'}

  has_one_attached :image
	
	def self.check(query)
		 where("name = ? OR bar = ?", "#{query}", "#{query}")
	end
end
