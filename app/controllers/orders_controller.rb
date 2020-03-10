class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [ :edit, :update, :destroy]

  def index
    if current_user
      if current_user.role.en == "admin"
        @orders = Order.all
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end


  def new
    if current_user
      if current_user.role.en == "admin"
        @order = Order.new
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def edit
    if current_user
      if current_user.role.en == "admin"
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def create
    if current_user
      if current_user.role.en == "admin"
        @order = Order.new(order_params)
        respond_to do |format|
          if @order.save
            format.html { redirect_to orders_path, notice: 'Шинэ захиалга амжилттай бүртгэгдлээ.' }
          else
            format.html { render :new }
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
      if current_user.role.en == "admin"
        respond_to do |format|
          if @order.update(order_params)
            format.html { redirect_to orders_path, notice: 'Захиалга амжилттай шинэчлэгдлээ.' }
          else
            format.html { render :edit }
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
        @order = Order.find(params[:id])
        @order.update_attribute(:check, true)
        @order.update_attribute(:recieved, Time.now)
        redirect_to orders_path
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def destroy
    if current_user
      if current_user.role.en == "admin"
        @order.destroy
        respond_to do |format|
          format.html { redirect_to orders_url, notice: 'Захиалгыг амжилттай устгалаа.' }
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
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :bar, :check, :price)
    end
end
