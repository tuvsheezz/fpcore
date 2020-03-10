class SubcategoryLogsController< ApplicationController
  before_action :authenticate_user!
  before_action :set_subcategory_log, only: [:show, :edit, :update, :destroy]

  def index
    if current_user
      if current_user.role.en == "admin"
        @subcategory_logs = SubcategoryLog.all.order("created_at ASC")
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def create
    @subcategory_log = SubcategoryLog.new(category_log_params)
  end

  private
    def set_category_log
      @subcategory_log = SubcategoryLog.find(params[:id])
    end

    def subcategory_log_params
      params.require(:category_log).permit(:subcategory_id, :category_id, :user_id, :name, :avatar, :note)
    end
end
