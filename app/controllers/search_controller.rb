class SearchController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user
      if current_user.role.en == "nyarav" or current_user.role.en == "seller" or current_user.role.en == "admin"
      	@products = Product.all
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
     end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end
end
