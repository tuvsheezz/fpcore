class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock, only: [:show, :report, :edit, :update]

  # GET /stocks
  # GET /stocks.json
  def index
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "nyabo"
        @stocks = Stock.all
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "nyabo"
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def report
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "nyabo"
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  # GET /stocks/new
  def new
    if current_user
      if current_user.role.en == "nyabo"
        @stock = Stock.new
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  # GET /stocks/1/edit
  def edit
    if current_user
      if current_user.role.en == "nyabo"
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  # POST /stocks
  # POST /stocks.json
  def create
    if current_user
      if current_user.role.en == "nyabo"
        @stock = Stock.new(stock_params)
        respond_to do |format|
          @stock.nyabo_id = current_user.id
          if @stock.save
            format.html { redirect_to @stock, notice: 'Шинэ тооллог амжилттай бүртгэгдлээ.' }
            format.json { render :show, status: :created, location: @stock }
          else
            format.html { render :new }
            format.json { render json: @stock.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  # PATCH/PUT /stocks/1
  # PATCH/PUT /stocks/1.json
  def update
    if current_user
      if current_user.role.en == "nyabo"
        @stock.nyabo_id = current_user.id
        respond_to do |format|
          if @stock.update(stock_params)
            format.html { redirect_to @stock, notice: 'Бүртгэл амжилттай шинэчлэгдлээ.' }
            format.json { render :show, status: :ok, location: @stock }
          else
            format.html { render :edit }
            format.json { render json: @stock.errors, status: :unprocessable_entity }
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
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      params.require(:stock).permit(:seller_id, :nyabo_id, :branch_id, stoks_attributes: [:id, :_destroy, :item_id, :amount, :stock_id])
    end
end
