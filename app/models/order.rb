class Order < ApplicationRecord
	validates :name, presence: {message: 'хоосон байж болохгүй' }
	validates :bar, presence: {message: 'хоосон байж болохгүй' }
	validates :price, presence: {message: 'хоосон байж болохгүй' }
end
