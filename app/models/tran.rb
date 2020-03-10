class Tran < ApplicationRecord
  belongs_to :transfer, optional: true
  belongs_to :item

  	def item_id
		item.try(:name)
	end

	def item_id=(query)
		self.item = Item.find_by_name(query) if query.present?
	end
end
