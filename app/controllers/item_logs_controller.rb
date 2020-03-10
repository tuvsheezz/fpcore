class ItemLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item_log, only: [:show, :edit, :update, :destroy]

  def index
    if current_user
      if current_user.role.en == "admin"
        @item_logs = ItemLog.all
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def create
    @item_log = ItemLog.new(item_log_params)
  end

  private
    def set_item_log
      @item_log = ItemLog.find(params[:id])
    end

    def item_log_params
      params.require(:item_log).permit(:item_id, :name, :name_mn, :user_id, :bar, :image, :subcategory_id, :price, :maxp, :minp, :minimum, :currency_id, :note, :status)
    end
end
