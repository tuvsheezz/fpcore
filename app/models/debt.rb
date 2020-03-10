class Debt < ApplicationRecord
  belongs_to :sale
  belongs_to :user
  belongs_to :branch

	def paid=(new_value)
  	if read_attribute(:paid)
  		@old_amount = read_attribute(:paid)
  		write_attribute(:paid, new_value.to_i + @old_amount)

  		@old_rem = read_attribute(:remainder)
  		write_attribute(:remainder, @old_rem - new_value.to_i)

  		@rem = read_attribute(:remainder)
  		if @rem <= 0
  			write_attribute(:status, 1)
  		else
  			write_attribute(:status, 0)
  		end

  		@sale = Sale.find_by_id(self.sale_id)
  		@sale.remainder = self.remainder
  		@sale.save

  	else
  		write_attribute(:paid, new_value.to_i)
  	end
	end
end
