class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update]

  def index
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "seller" or current_user.role.en == "nyarav"
        @categories = Category.all
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
        @category = Category.find(params[:id])
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
        @category = Category.new
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
        @category = Category.find(params[:id])
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
        @category = Category.new(category_params)
        if @category.save

          redirect_to @category, flash: {notice: t('category.status.created')}
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
        if @category.update(category_params)
          redirect_to @category, notice: t('category.status.updated')
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
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :image)
    end
end
