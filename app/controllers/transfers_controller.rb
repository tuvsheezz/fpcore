class TransfersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transfer, only: [:show, :edit, :update, :destroy, :check]

  def index
    if current_user
      if current_user.role.en == "admin"
        @transfers = Transfer.all
      elsif current_user.role.en == "seller" or current_user.role.en == "nyarav"
        @transfers = Transfer.where(bto: current_user.branch_id) + Transfer.where(bfrom: current_user.branch_id)
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def show
    if current_user
      if current_user.role.en == "admin"
      elsif current_user.role.en == "seller" or current_user.role.en == "nyarav"
        if @transfer.uto == current_user.id or @transfer.ufrom == current_user.id or @transfer.bto == current_user.branch_id or @transfer.bfrom == current_user.branch_id
        else
          redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
        end
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def new
    if current_user
      if current_user.role.en == "seller" or current_user.role.en == "nyarav"
        @transfer = Transfer.new
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def edit
    if current_user
      if current_user.role.en == "seller" or current_user.role.en == "nyarav"
        if current_user.id == @transfer.ufrom and @transfer.check == false and @transfer.checker == true
        else
          redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
        end
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def create
    if current_user
      if current_user.role.en == "seller" or current_user.role.en == "nyarav"
        @transfer = Transfer.new(transfer_params)
        @transfer.bfrom = current_user.branch_id
        @transfer.ufrom = current_user.id
        respond_to do |format|
          if @transfer.save
            format.html { redirect_to @transfer, notice: t('transfer.created') }
            format.json { render :show, status: :created, location: @transfer }
          else
            format.html { render :new }
            format.json { render json: @transfer.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def update
    if current_user
      if current_user.role.en == "seller" or current_user.role.en == "nyarav"
        if current_user.id == @transfer.ufrom and @transfer.check == false and @transfer.checker == true
          respond_to do |format|
            if @transfer.update(transfer_params)
              format.html { redirect_to @transfer, notice: t('transfer.updated') }
              format.json { render :show, status: :ok, location: @transfer }
            else
              format.html { render :edit }
              format.json { render json: @transfer.errors, status: :unprocessable_entity }
            end
          end
        else
          redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
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
      if current_user.role.en == "seller" or current_user.role.en == "nyarav"
        @transfer = Transfer.find(params[:id])
        @transfer.trans.each do |t|
          if Product.find_by_item_id_and_branch_id(t.item.id, current_user.branch_id)
          else
            Product.create(item_name: t.item.bar, branch_id: current_user.branch_id, user_id: current_user.id, amount: 0)
          end
        end
        @transfer.update_attributes(check: true, uto: current_user.id)
        redirect_to @transfer
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def destroy
    if current_user
      if current_user.role.en == "seller" or current_user.role.en == "nyarav"
        if  @transfer.ufrom == current_user.id and @transfer.check == false and @transfer.checker == true
          @transfer.destroy
          respond_to do |format|
            format.html { redirect_to transfers_url, alert: t('transfer.deleted') }
            format.json { head :no_content }
          end
        else
          redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
        end
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  private
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    def transfer_check_params
      params.require(:transfer).permit(:check)
    end

    def transfer_params
      params.require(:transfer).permit(:bto, :bfrom, :uto, :ufrom, trans_attributes: [:id, :_destroy, :item_id, :amount, :transfer_id])
    end
end
