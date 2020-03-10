class RatedollarsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user
      if current_user
        respond_to do |format|
          format.html
          format.json { render json: RatedollarDatatable.new(params) }
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
        @ratedollar = Ratedollar.new
        DollarLog.create(user_id: current_user.id, note: "долларын ханш нэмэх үүсгэх цонх руу хандсан.")
      else
        DollarLog.create(user_id: current_user.id, note: "долларын ханш нэмэх үүсгэх цонх руу хандaxыг оролдсон.")
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def create
    if current_user
      if current_user.role.en == "admin"
        @ratedollar = Ratedollar.new(ratedollar_params)
        @ratedollar.user_id = current_user.id
        if @ratedollar.save
          DollarLog.create(dollar_id: @ratedollar.id, rate: @ratedollar.rate, user_id: current_user.id, note: "долларын ханш бүртгэлээ.")
          redirect_to ratedollars_path, notice: t('dollar.success')
        else
          render :new
        end
      else
        DollarLog.create(user_id: current_user.id, note: "шинэ долларын ханш бүртгэхийг оролдсон.")
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  private
    def ratedollar_params
      params.require(:ratedollar).permit(:rate, :user_id)
    end
end
