class MachigainaoshisController < ApplicationController
  before_action :authenticate_user!
  before_action :set_machigainaoshi, only: [:update, :destroy]

  # GET /machigainaoshis
  # GET /machigainaoshis.json
  def index
    if current_user
      if current_user.role.en == "nyabo" or current_user.role.en == "admin"
        @machigainaoshis = Machigainaoshi.all
      elsif current_user.role.en == "seller" or current_user.role.en == "nyarav"
        @machigainaoshis = Machigainaoshi.where(branch_id: current_user.branch_id)
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

    # GET /machigainaoshis/new
  def new
    if current_user
      if current_user.role.en == "nyabo"
        @machigainaoshi = Machigainaoshi.new
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  # POST /machigainaoshis
  # POST /machigainaoshis.json
  def create
    if current_user
      if current_user.role.en == "nyabo"
        @machigainaoshi = Machigainaoshi.new(machigainaoshi_params)
        @machigainaoshi.nybo_id = current_user.id
        respond_to do |format|
          if @machigainaoshi.save
            @itemid = @machigainaoshi.item_id
            @branchid = @machigainaoshi.branch_id
            @machigainaoshi.product_id = Product.find_by_item_id_and_branch_id(@itemid, @branchid).id
            @machigainaoshi.save
            format.html { redirect_to machigainaoshis_path, notice: 'Үйлдэл амжилттай боллоо.' }
            format.json { render :show, status: :created, location: @machigainaoshi }
          else
            format.html { render :new }
            format.json { render json: @machigainaoshi.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end

  end

  def check
    if current_user
      if current_user.role.en == "admin"
        @machigainaoshi = Machigainaoshi.find(params[:id])
        if !@machigainaoshi.admin_id and !@machigainaoshi.check
          @machigainaoshi.update_attribute(:check, true)
          @machigainaoshi.update_attribute(:admin_id, current_user.id)
        end
        redirect_to machigainaoshis_path
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_machigainaoshi
      @machigainaoshi = Machigainaoshi.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def machigainaoshi_params
      params.require(:machigainaoshi).permit(:item_name, :product_id, :branch_id, :nybo_id, :seller_id, :admin_id, :amount, :pre_stat, :check, :note)
    end
end
