class SalesController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "nyabo"
        @sales =  Sale.all
      elsif current_user.role.en == "nyarav" or current_user.role.en == "seller"
        @sales = Sale.where(branch_id: current_user.branch_id)
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def show
    if current_user
      if current_user.role.en == "nyarav" or current_user.role.en == "seller" or current_user.role.en == "admin" or current_user.role.en == "nyabo"
        @sale = Sale.find(params[:id])
        @tasks = @sale.tasks.all
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def new
    if current_user
      if current_user.role.en == "nyarav" or current_user.role.en == "seller"
        @sale = Sale.new
        # @sale.tasks.build
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
        @sale = Sale.new(sale_params)
        @sale.branch_id = current_user.branch_id
        @sale.user_id = current_user.id
        if @sale.save
          @sale.tasks.each do |tsk|
            if tsk.item_id
              if Product.where(item_id: tsk.item.id, branch_id: @sale.branch_id).last
                @product = Product.where(item_id: tsk.item.id, branch_id: @sale.branch_id).last
                @product.amount = -tsk.amount
                @product.save
                Prodchange.create(branch_id: @sale.branch_id, user_id: current_user.id, product_id: @product.id, change: -tsk.amount)

              end
            end
          end

          if @sale.salestatus.en == "zeel"
            Debt.create(sale_id: @sale.id, user_id: current_user.id, branch_id: current_user.branch_id, remainder: @sale.remainder, paid: @sale.total - @sale.remainder , amount: @sale.total, note: @sale.note)
          end
          redirect_to @sale, notice: 'Гүйлгээ амжилттай хийгдлээ.'
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

  def edit
    if current_user
      if current_user.role.en == "nyarav"
        @sale = Sale.find(params[:id])
      else
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def update
    if current_user
      if current_user.role.en == "nyarav"
        @sale = Sale.find(params[:id])
        if @sale.update(edit_params)
          @sale.taks.each do |tsk|
            if tsk.item_id
              if Product.where(item_id: tsk.item.id, branch_id: @sale.branch_id).last
                @product = Product.where(item_id: tsk.item.id, branch_id: @sale.branch_id).last
                @product.amount = +tsk.amount
                @product.save

                Prodchange.create(branch_id: @sale.branch_id, user_id: current_user.id, product_id: @product.id, change: tsk.amount)

              else
                @product = Product.create(item_name: tsk.item_id, branch_id: current_user.branch_id, user_id: current_user.id, amount: 0)
                @product.amount = +tsk.amount
                @product.save

                Prodchange.create(branch_id: @sale.branch_id, user_id: current_user.id, product_id: @product.id, change: tsk.amount)
              end
            end
          end
          if Debt.find_by_sale_id(@sale.id)
            @debt = Debt.find_by_sale_id(@sale.id)
            @debt.note = @sale.note

            @sale.taks.each do |tsk|
              if tsk.checker
                @debt.remainder -= tsk.total
                @sale.remainder -= tsk.total
                tsk.checker = 0
                tsk.save
              end
            end

            if @debt.remainder < 0
              @debt.remainder = 0
              @sale.remainder = 0
            end
            @debt.save
            @sale.save
          end
          redirect_to @sale, notice: 'Гүйлгээний буцаалт амжилттай хийгдлээ.'
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
    def edit_params
      params.require(:sale).permit(:branch_id, :user_id, :noat, :tax, :salestatus_id, :remainder, :total, :note, taks_attributes: [:id, :_destroy, :item_id, :sale_id, :amount, :price, :subs, :percent, :total, :user_id ])
    end
    def sale_params
      params.require(:sale).permit(:branch_id, :user_id, :noat, :tax, :salestatus_id, :remainder, :total, :note, tasks_attributes: [:id, :_destroy, :item_id, :sale_id, :amount, :total, :price ])
    end
end
