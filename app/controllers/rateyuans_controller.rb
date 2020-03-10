class RateyuansController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user
      if current_user
        respond_to do |format|
          format.html
          format.json { render json: RateyuanDatatable.new(params) }
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
      if current_user.role.en == "admin"
        @rateyuan = Rateyuan.new
        YuanLog.create(user_id: current_user.id, note: "юаний ханш нэмэх үүсгэх цонх руу хандсан.")
      else
        YuanLog.create(user_id: current_user.id, note: "юаний ханш нэмэх үүсгэх цонх руу хандaxыг оролдсон.")
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def create
    if current_user
      if current_user.role.en == "admin"
        @rateyuan = Rateyuan.new(rateyuan_params)
        @rateyuan.user_id = current_user.id
        if @rateyuan.save
          YuanLog.create(yuan_id: @rateyuan.id, rate: @rateyuan.rate, user_id: current_user.id, note: "юаний ханш бүртгэлээ.")
          redirect_to rateyuans_path, notice: t('yuan.success')
        else
          render :new
        end
      else
        YuanLog.create(user_id: current_user.id, note: "шинэ юаний ханш бүртгэхийг оролдсон.")
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  private
    def rateyuan_params
      params.require(:rateyuan).permit(:rate)
    end
end
