class Tak < ApplicationRecord
  belongs_to :sale, optional: true
  belongs_to :item
  belongs_to :user

  def item_id
		item.try(:name)
	end

	def item_id=(query)
		self.item = Item.find_by_name(query) if query.present?
	end
end
