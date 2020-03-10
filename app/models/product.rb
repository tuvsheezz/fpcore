class Product < ApplicationRecord
	include ActiveModel::Dirty
	belongs_to :item
	belongs_to :user
	belongs_to :branch
	has_many :prodchanges
	validates :amount, numericality: {greater_than_or_equal_to: 0}

	def item_name
		item.try(:bar)
	end

	def item_name=(query)
		self.item = Item.find_by_bar(query) if query.present?
	end

	def amount=(new_value)
    	if read_attribute(:amount)
    		@old_amount = read_attribute(:amount)
    		write_attribute(:amount, new_value.to_i + @old_amount)
    		# write_attribute(:pre_amount, @old_amount)
    	else
    		write_attribute(:amount, new_value.to_i)
    	end
 	end

	def save_amount_change

	end
end
