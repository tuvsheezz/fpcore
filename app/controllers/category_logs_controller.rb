class CategoryLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category_log, only: [:show, :edit, :update, :destroy]

  def index
    if current_user
      if current_user.role.en == "admin"
        @category_logs = CategoryLog.all.order("created_at ASC")
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def create
    @category_log = CategoryLog.new(category_log_params)
  end

  private
    def set_category_log
      @category_log = CategoryLog.find(params[:id])
    end

    def category_log_params
      params.require(:category_log).permit(:category_id, :user_id, :name, :image, :note)
    end
end
