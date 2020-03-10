class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:edit, :update, :show]

  def index
    if current_user
      if current_user.role.en == "admin"
        @products = Product.group(:item_id)
        @sum = Product.group(:item_id).sum(:amount)

      elsif current_user.role.en == "seller" or current_user.role.en == "nyarav"
        @products = Product.where(branch_id: current_user.branch_id)
        @sum = Product.where(branch_id: current_user.branch_id).group(:item_id).sum(:amount)
        if params[:check]
          if params[:check] == ''
              redirect_to check_products_path, flash: {alert: t('item.cantbeblank')}
          else
            if Item.find_by_name(params[:check])
              if @product = Product.where(branch_id: current_user.branch_id, item_id: Item.find_by_name(params[:check]).id).order("created_at DESC").first
                redirect_to edit_product_path(@product), flash: {notice: t('item.found')}
              else
                redirect_to new_product_path, flash: {notice: t('item.notfound')}
              end
            elsif Item.find_by_bar(params[:check])
              if @product = Product.where(branch_id: current_user.branch_id, item_id: Item.find_by_bar(params[:check]).id).order("created_at DESC").first
                redirect_to edit_product_path(@product), flash: {notice: t('item.found')}
              else
                redirect_to new_product_path, flash: {notice: t('item.notfound')}
              end
            else
              redirect_to new_product_path, flash: {notice: t('item.notfound')}
            end
          end
        end
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def bybranchid
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "nyabo"
        @branch = Branch.find_by_id(params[:branch_id])
        @products = Product.where(branch_id: params[:branch_id])
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def print
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "nyabo"
        @branch = Branch.find_by_id(params[:branch_id])
        @products = Product.where(branch_id: params[:branch_id])
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

  def show
    if current_user
      if current_user.role.en == "nyarav" or current_user.role.en == "seller"
        if @product.branch_id == current_user.branch_id
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
      if current_user.role.en == "nyarav" or current_user.role.en == "seller"
        if current_user.branch_id == 4 and current_user.id == 6
          redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
        else
        end
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def select
    if current_user
      if current_user.role.en == "nyarav" or current_user.role.en == "seller"
        if Item.find_by_bar(params['id'])
          @item = Item.find_by_bar(params['id'])
          @name = @item.name
          @item_id =  Item.find_by_bar(params['id']).id
          if Product.where(branch_id: current_user.branch_id, item_id: @item_id).any?
            @amount = Product.where(branch_id: current_user.branch_id, item_id: @item_id).last.amount
            if @item.currency.currency_name == "dollar"
              @maxp = @item.maxp * Ratedollar.last.rate
              @minp = @item.minp * Ratedollar.last.rate
            elsif @item.currency.currency_name == "yuan"
              @maxp = @item.maxp * Rateyuan.last.rate
              @minp = @item.minp * Rateyuan.last.rate
            else
              @maxp = @item.maxp
              @minp = @item.minp
            end
            if @amount == 0
              respond_to do |format|
                format.json { render json: []}
              end
            else
              respond_to do |format|
                format.json { render json: [maxp: (@maxp).ceil(-2), minp: (@minp).ceil(-2), amount: @amount, name: @name]}
              end
            end
          end
        else
          respond_to do |format|
            format.json { render json: []}
          end
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
      if current_user.role.en == "nyarav"
        @product = Product.new
        @amount = 0
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

        if current_user.branch_id == 4 and current_user.id == 6
          redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
        else
          @amount = @product.amount
          @name = @product.item_name
        end
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def create
    @product = Product.new(product_params)
    @product.branch = Branch.find_by_id(current_user.branch_id)
    @product.user = current_user

    if @product.save
      #uurchlult hadgalah
      Prodchange.create(branch_id: current_user.branch_id, user_id: current_user.id, product_id: @product.id, change: @product.amount - @product.pre_amount)

      redirect_to products_path, notice: t('product.created.')

    else
      render :new
    end
  end

  def update
    @product.branch = Branch.find_by_id(current_user.branch_id)
    @product.user = current_user
    @product.pre_amount = @product.amount

    if @product.update(product_params)

      Prodchange.create(branch_id: current_user.branch_id, user_id: current_user.id, product_id: @product.id, change: @product.amount - @product.pre_amount)

      redirect_to products_path, notice: t('product.updated.')
    else
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:item_name, :branch_id, :user_id, :amount, :pre_amount)
    end
end
