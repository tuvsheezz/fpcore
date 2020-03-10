class OutofstockController < ApplicationController
  before_action :authenticate_user!
  def index
  	if current_user
	  	if current_user.role.en == "admin"
	  		@products = Product.all.group(:item_id)
        @sum = Product.group(:item_id).sum(:amount)
	  	elsif current_user.role.en == "seller" or current_user.role.en == "nyarav"
	  		@products = Product.where(branch_id: current_user.branch_id, amount: 0)
	  	else
	  		redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
     	end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end
end
