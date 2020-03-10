class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update]

  def index
    if current_user
      if current_user
        @items = Item.where(status_id: Status.where(en: "idevhtei")).order(bar: "asc")

        if params[:check]
          if params[:check] == ''
              redirect_to new_item_path, flash: {alert: t('item.cantbeblank')}
          else
            if @item = Item.all.check(params[:check]).order("created_at DESC").first
              redirect_to edit_item_path(@item), flash: {notice: t('item.found')}
            else
              redirect_to new_item_path, flash: {notice: t('item.notfound')}
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

  def show
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "nyarav" or current_user.role.en == "seller" or current_user.role.en == "nyabo"
        @item = Item.find(params[:id])
        #ItemLog.create(item_id: @item.id, subcategory_id: @item.subcategory.id, user_id: current_user.id, name: @item.name, name_mn: @item.name_mn, avatar: @item.avatar, price: @item.price, minp: @item.minp, maxp: @item.maxp, currency_id: @item.currency_id, minimum: @item.minimum, bar: @item.bar, status: @item.status.id, note: "барааны мэдээллийг xapcaн.")
      else
        #ItemLog.create(item_id: @item.id, subcategory_id: @item.subcategory.id, user_id: current_user.id, name: @item.name, name_mn: @item.name_mn, avatar: @item.avatar, price: @item.price, minp: @item.minp, maxp: @item.maxp, currency_id: @item.currency_id, minimum: @item.minimum, bar: @item.bar, status: @item.status.id,  note: "барааны мэдээллийг xapaxыг оролдсон.")
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def new
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "nyarav"
        @item = Item.new
        # ItemLog.create(user_id: current_user.id, note: "шинэ бараа үүсгэх цонх руу хандсан.")
      else
        # ItemLog.create(user_id: current_user.id, note: "шинэ бараа үүсгэх цонх руу хандахыг оролдсон.")
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def edit
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "nyarav"
        @item = Item.find(params[:id])
     else
       redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
     end
   else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def create
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "nyarav"
        @item = Item.new(item_params)
        if @item.save
          @item.update_attribute(:bar, "B#{@item.subcategory.category.id}#{@item.subcategory.id}#{@item.id}")

          redirect_to @item, notice: t('item.status.created')
        else
          render :new
        end
      else
        # ItemLog.create(user_id: current_user.id, note: "шинэ бараа бүртгэхийг оролдсон.")
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def update
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "nyarav"
        if @item.update(item_params)
          #ItemLog.create(item_id: @item.id, subcategory_id: @item.subcategory.id, user_id: current_user.id, name: @item.name, name_mn: @item.name_mn, avatar: @item.avatar, price: @item.price, minp: @item.minp, maxp: @item.maxp, currency_id: @item.currency_id, minimum: @item.minimum, bar: @item.bar, status: @item.status.id,  note: "барааны мэдээллийг болгож шинэчлэсэн.")
          @item.update_attribute(:bar, "B#{@item.subcategory.category.id}#{@item.subcategory.id}#{@item.id}")
          redirect_to @item, notice: t('item.status.updated')
        else
          render :edit
        end
      else
        #ItemLog.create(item_id: @item.id, subcategory_id: @item.subcategory.id, user_id: current_user.id, name: @item.name, name_mn: @item.name_mn, avatar: @item.avatar, price: @item.price, minp: @item.minp, maxp: @item.maxp, currency_id: @item.currency_id, minimum: @item.minimum, bar: @item.bar, status: @item.status.id, note: "барааны мэдээллийг болгож шинэчлэхийг оролдсон.")
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def select
    if current_user
      if Item.find_by_bar(params['id'])
        @name = Item.find_by_bar(params['id']).name
        @iid = Item.find_by_bar(params['id']).id
        @price = Task.find_by_sale_id_and_item_id(params['sale'], @iid).price
        respond_to do |format|
          format.json { render json: [name: @name, price: @price]}
        end
      else
        respond_to do |format|
          format.json { render json: []}
        end
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def select2
    if current_user
      if Item.find_by_bar(params['id'])
        @name = Item.find_by_bar(params['id']).name
        respond_to do |format|
          format.json { render json: [name: @name] }
        end
      else
        respond_to do |format|``
          format.json { render json: []}
        end
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
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

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :name_mn, :subcategory_id, :price, :maxp, :minp, :bar, :image, :currency_id, :minimum, :status_id, :spec, :specialp, :special_flag)
    end
end
