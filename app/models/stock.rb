class Stock < ApplicationRecord
  has_many :stoks, dependent: :destroy
  accepts_nested_attributes_for :stoks, allow_destroy: true, reject_if: proc { |att| att['item_id'].blank? }
  validates :seller_id, presence: {message: 'хоосон байж болохгүй' }
  validates :branch_id, presence: {message: 'хоосон байж болохгүй' }
end
