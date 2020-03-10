class Prodchange < ApplicationRecord
  belongs_to :branch
  belongs_to :user
  belongs_to :product
end
