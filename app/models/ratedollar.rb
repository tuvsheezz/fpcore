class Ratedollar < ApplicationRecord
	belongs_to :user
	validates :rate, presence: {message: 'хоосон байж болохгүй' }
end
