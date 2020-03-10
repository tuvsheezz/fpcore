class RetsaleController < ApplicationController
  before_action :authenticate_user!
  def index
  	if current_user
      if current_user.role.en == "nyarav"
      	@sales = Sale.all
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end
end
