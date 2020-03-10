class FactoryreturnsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_factoryreturn, only: [:show, :destroy]

  # GET /factoryreturns
  # GET /factoryreturns.json
  def index
    if current_user
      if current_user.role.en == "nyarav"
        @factoryreturns = Factoryreturn.all
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  # GET /factoryreturns/1
  # GET /factoryreturns/1.json
  def show
  end

  # GET /factoryreturns/new
  def new
    if current_user
      if current_user.role.en == "nyarav"
        @factoryreturn = Factoryreturn.new
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  # POST /factoryreturns
  # POST /factoryreturns.json
  def create
    if current_user
      if current_user.role.en == "nyarav"
        @factoryreturn = Factoryreturn.new(new_factoryreturn_params)
        respond_to do |format|
          if @factoryreturn.save
            if @factoryreturn.from
              @product = Product.find_by_item_id_and_branch_id(@factoryreturn.item_id, current_user.branch_id)
              @product.amount = -1
              @product.save

              Prodchange.create(branch_id: current_user.branch_id, user_id: current_user.id, product_id: @product.id,
                change: -1)

            end
            format.html { redirect_to @factoryreturn, notice: 'Шинэ буцаалт бүртгэгдлээ.' }
            format.json { render :show, status: :created, location: @factoryreturn }
          else
            format.html { render :new }
            format.json { render json: @factoryreturn.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  # DELETE /factoryreturns/1
  # DELETE /factoryreturns/1.json
  def destroy
    if current_user
      if current_user.role.en == "nyarav"
        if @factoryreturn.sent or @factoryreturn.reced or @factoryreturn.gave
          redirect_to factoryreturns_url, flash: {alert: 'Устгах боломжгүй.'}
        else
          if @factoryreturn.from
            @product = Product.find_by_item_id_and_branch_id(@factoryreturn.item_id, current_user.branch_id)
            @product.amount = 1
            @product.save

            Prodchange.create(branch_id: current_user.branch_id, user_id: current_user.id, product_id: @product.id, change: 1)

          end
          @factoryreturn.destroy
          respond_to do |format|
            format.html { redirect_to factoryreturns_url, notice: 'Устгалаа шүү!!!' }
            format.json { head :no_content }
          end
        end
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def sent
    if current_user
      if current_user.role.en == "nyarav"
        @factoryreturn = Factoryreturn.find(params[:id])
        @factoryreturn.update_attribute(:sent, true)
        @factoryreturn.update_attribute(:datesent, Time.now)
        redirect_to factoryreturns_path
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def rec
    if current_user
      if current_user.role.en == "nyarav"
        @factoryreturn = Factoryreturn.find(params[:id])
        @factoryreturn.update_attribute(:reced, true)
        @factoryreturn.update_attribute(:daterec, Time.now)
        @product = Product.find_by_item_id_and_branch_id(@factoryreturn.item_id, current_user.branch_id)
        @product.amount = 1
        @product.save

        Prodchange.create(branch_id: current_user.branch_id, user_id: current_user.id, product_id: @product.id, change: 1)

        redirect_to factoryreturns_path
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def gave
    if current_user
      if current_user.role.en == "nyarav"
        @factoryreturn = Factoryreturn.find(params[:id])
        @factoryreturn.update_attribute(:gave, true)
        @factoryreturn.update_attribute(:dategave, Time.now)
        if !@factoryreturn.from
          @product = Product.find_by_item_id_and_branch_id(@factoryreturn.item_id, current_user.branch_id)
          @product.amount = -1
          @product.save

          Prodchange.create(branch_id: current_user.branch_id, user_id: current_user.id, product_id: @product.id, change: -1)

        end
        redirect_to factoryreturns_path
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_factoryreturn
      @factoryreturn = Factoryreturn.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.

    def new_factoryreturn_params
      params.require(:factoryreturn).permit(:item_name, :from, :note, :user_id)
    end

    def factoryreturn_params
      params.require(:factoryreturn).permit(:item_id, :sent, :datesent, :reced, :daterec, :gave, :dategave, :note, :user_id)
    end
end
