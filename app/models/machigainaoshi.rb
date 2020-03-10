class Machigainaoshi < ApplicationRecord
	belongs_to :item
  belongs_to :product
  belongs_to :branch
	validates :branch_id, presence: {message: 'хоосон байж болохгүй' }
	validates :seller_id, presence: {message: 'хоосон байж болохгүй' }
	validates :item_name, presence: {message: 'хоосон байж болохгүй' }
	validates :amount, presence: {message: 'хоосон байж болохгүй' }
	def item_name
		item.try(:bar)
	end

	def item_name=(query)
		self.item = Item.find_by_bar(query) if query.present?
	end

	after_save :changeIt

	def changeIt
		if self.check and self.admin_id
			@product = Product.find_by_id(self.product_id)
			if self.pre_stat
				@product.amount = self.amount
				Prodchange.create(branch_id: self.branch_id, user_id: self.admin_id, product_id: @product.id, change: self.amount)

			else
				@product.amount = -self.amount
				Prodchange.create(branch_id: self.branch_id, user_id: self.admin_id, product_id: @product.id, change: -self.amount)
			end
			@product.save
		end
	end
end
