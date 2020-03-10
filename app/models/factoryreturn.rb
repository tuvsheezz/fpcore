class Factoryreturn < ApplicationRecord
  belongs_to :item
	def item_name
		item.try(:bar)
	end

	def item_name=(query)
		self.item = Item.find_by_bar(query) if query.present?
	end
end
