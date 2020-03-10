class Sale < ApplicationRecord
	belongs_to :salestatus
	belongs_to :branch
  belongs_to :user
	has_one :debt
	has_many :tasks, dependent: :destroy
	accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: proc { |att| att['item_id'].blank? }

	has_many :taks, dependent: :destroy
	accepts_nested_attributes_for :taks, allow_destroy: true, reject_if: proc { |att| att['item_id'].blank? }
end
