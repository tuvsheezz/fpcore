class BalanceController < ApplicationController
  before_action :authenticate_user!
  def index
	if current_user
		if current_user.role.en == "admin" or current_user.role.en == "nyabo"
	  		@products = Product.all
	  		@items = Item.where(status_id: 1).order(:subcategory_id)
	  		@dollar = Ratedollar.last.rate
	  		@yuan = Rateyuan.last.rate
      else
    		redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
    	end
  	else
  		redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
   	end
  end
end
