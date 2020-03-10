class ProdchangesController < ApplicationController
  before_action :set_prodchange, only: [:show, :edit, :update, :destroy]

  # GET /prodchanges
  # GET /prodchanges.json
  def index
    @prodchanges = Prodchange.all
  end

  # GET /prodchanges/1
  # GET /prodchanges/1.json
  def show
  end

  # GET /prodchanges/new
  def new
    @prodchange = Prodchange.new
  end

  # GET /prodchanges/1/edit
  def edit
  end

  # POST /prodchanges
  # POST /prodchanges.json
  def create
    @prodchange = Prodchange.new(prodchange_params)

    respond_to do |format|
      if @prodchange.save
        format.html { redirect_to @prodchange, notice: 'Prodchange was successfully created.' }
        format.json { render :show, status: :created, location: @prodchange }
      else
        format.html { render :new }
        format.json { render json: @prodchange.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prodchanges/1
  # PATCH/PUT /prodchanges/1.json
  def update
    respond_to do |format|
      if @prodchange.update(prodchange_params)
        format.html { redirect_to @prodchange, notice: 'Prodchange was successfully updated.' }
        format.json { render :show, status: :ok, location: @prodchange }
      else
        format.html { render :edit }
        format.json { render json: @prodchange.errors, status: :unprocessable_entity }
      end
    end
  end

  def report
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "nyabo"
        @categories = Category.all
        @subcategories = Subcategory.all
        @items = Item.all
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  # DELETE /prodchanges/1
  # DELETE /prodchanges/1.json
  def destroy
    @prodchange.destroy
    respond_to do |format|
      format.html { redirect_to prodchanges_url, notice: 'Prodchange was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prodchange
      @prodchange = Prodchange.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prodchange_params
      params.require(:prodchange).permit(:branch_id, :user_id, :product_id, :change)
    end
end
