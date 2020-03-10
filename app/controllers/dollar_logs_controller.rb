class DollarLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dollar_log, only: [:show, :edit, :update, :destroy]

  def index
    if current_user
      if current_user.role.en == "admin"
        @dollar_logs = DollarLog.all
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def create
    @dollar_log = DollarLog.new(dollar_log_params)
  end

  private
    def set_dollar_log
      @dollar_log = DollarLog.find(params[:id])
    end

    def dollar_log_params
      params.require(:dollar_log).permit(:dollar_id, :user_id, :note, :rate)
    end
end
