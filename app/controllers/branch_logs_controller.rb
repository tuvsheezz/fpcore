class BranchLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_branch_log, only: [:show, :edit, :update, :destroy]

  def index
    if current_user
      if current_user.role.en == "admin"
        @branch_logs = BranchLog.all.order("created_at ASC")
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def create
    @branch_log = BranchLog.new(branch_log_params)
  end

  private
    def set_branch_log
      @branch_log = BranchLog.find(params[:id])
    end

    def branch_log_params
      params.require(:branch_log).permit(:branch_id, :user_id, :name, :address, :image, :note)
    end
end
