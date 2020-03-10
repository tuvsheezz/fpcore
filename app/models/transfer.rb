class Transfer < ApplicationRecord
  belongs_to :item
	has_many :trans, dependent: :destroy
	accepts_nested_attributes_for :trans, allow_destroy: true, reject_if: proc { |att| att['item_id'].blank? }
	validates :bto, presence: true

	after_update :reciveIt

	def reciveIt
		if self.check and self.checker
			self.trans.each do |t|
				if Product.where(item_id: t.item.id, branch_id: self.bfrom).last
					@product = Product.where(item_id: t.item.id, branch_id: self.bfrom).last
					@product.amount = -t.amount
					@product.save

          Prodchange.create(branch_id: self.bfrom, user_id: self.ufrom, product_id: @product.id, change: -t.amount)
				end

				if Product.where(item_id: t.item.id, branch_id: self.bto).last
					@product = Product.where(item_id: t.item.id, branch_id: self.bto).last
					@product.amount = t.amount
					@product.save

          Prodchange.create(branch_id: self.bto, user_id: self.uto, product_id: @product.id, change: t.amount)
				end
			end
			update_attribute(:checker, 0)
		end
	end
end
