class DebtsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_debt, only: [:show, :edit, :update]

  def index
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "nyabo"
        @debts = Debt.where(status: false)
      elsif current_user.role.en == "seller" or current_user.role.en == "nyarav"
        @debts = Debt.where(status: false, branch_id: current_user.branch_id)
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def paid
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "nyabo"
        @debts = Debt.where(status: true)
      elsif current_user.role.en == "seller" or current_user.role.en == "nyarav"
        @debts = Debt.where(status: true, branch_id: current_user.branch_id)
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def show
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "nyabo"
        @sale = Sale.find_by_id(@debt.sale_id)
        @tasks = @sale.tasks.all
      elsif current_user.role.en == "seller" or current_user.role.en == "nyarav"
        if @debt.branch_id == current_user.branch_id
          @sale = Sale.find_by_id(@debt.sale_id)
          @tasks = @sale.tasks.all
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

  def edit
    if current_user
      if @debt.branch_id == current_user.branch_id
        @debt = Debt.find(params[:id])
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def create
    if current_user
      if current_user.role.en == "nyarav" or current_user.role.en == "seller"
        @debt = Debt.new(debt_params)
        respond_to do |format|
          if @debt.save
            format.html { redirect_to @debt, notice: 'Шинэ өр амжилттай бүртгэгдлээ.' }
            format.json { render :show, status: :created, location: @debt }
          else
            format.html { render :new }
            format.json { render json: @debt.errors, status: :unprocessable_entity }
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
      if current_user.role.en == "nyarav" or current_user.role.en == "seller"
        @debt = Debt.find(params[:id])
        respond_to do |format|
          if @debt.update(debt_paramsss)
            format.html { redirect_to @debt, notice: 'Өрийн мэдээлэл амжилттай шинэчлэгдлээ.' }
            format.json { render :show, status: :ok, location: @debt }
          else
            format.html { render :edit }
            format.json { render json: @debt.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_debt
      @debt = Debt.find(params[:id])
    end

    def debt_paramsss
      params.require(:debt).permit(:sale_id, :user_id, :branch_id, :remainder, :paid, :amount, :note)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def debt_params
      params.require(:debt).permit(:sale_id, :user_id, :branch_id, :remainder, :paid, :amount, :note)
    end
end
