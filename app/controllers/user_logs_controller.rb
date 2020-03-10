class UserLogsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user
      if current_user.role.en == "admin"
        @user_logs = UserLog.all
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def create
    @user_log = UserLog.new(user_log_params)
  end

  private
    def user_log_params
      params.require(:user_log).permit(:u_id, :user_id, :name, :branch_id, :role_id, :email, :password, :phone1, :phone2, :address, :image, :note)
    end
end
