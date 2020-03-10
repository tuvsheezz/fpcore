class YuanLogsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user
      if current_user.role.en == "admin"
        @yuan_logs = YuanLog.all
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def create
    @yuan_log = YuanLog.new(yuan_log_params)
  end

  private
    def yuan_log_params
      params.require(:yuan_log).permit(:yuan_id, :user_id, :note, :rate)
    end
end
