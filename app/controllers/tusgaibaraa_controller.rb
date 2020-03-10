class TusgaibaraaController < ApplicationController
  def index
  	if current_user
      if current_user.role.en == "admin" or current_user.role.en == "nyarav"
       @items = Item.where(special_flag: true)
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end
end
