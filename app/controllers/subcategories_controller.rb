class SubcategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subcategory, only: [:show, :edit, :update]

  def index
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "seller" or current_user.role.en == "nyarav"
        @subcategories = Subcategory.all
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def show
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "seller" or current_user.role.en == "nyarav"
        @subcategory = Subcategory.find(params[:id])
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
        @subcategory = Subcategory.new
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
        @subcategory = Subcategory.find(params[:id])
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
        @subcategory = Subcategory.new(subcategory_params)
        if @subcategory.save

          redirect_to @subcategory, notice: t('subcat.status.created')
        else
          render :new
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
        if @subcategory.update(subcategory_params)

          redirect_to @subcategory, notice: t('subcat.status.updated')
        else
          render :edit
        end
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  private
    def set_subcategory
      @subcategory = Subcategory.find(params[:id])
    end

    def subcategory_params
      params.require(:subcategory).permit(:name, :image, :category_id)
    end
end
