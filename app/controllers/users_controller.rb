class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "seller" or current_user.role.en == "nyarav"
        @users = User.all
      else
        UserLog.create(user_id: current_user.id, note: "хэрэглэгчид цонхруу хандаxыг оролдсон.")
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def show
    if current_user
      if current_user.role.en == "admin"
        @user = User.find(params[:id])
      else
        if User.find(params[:id]) == current_user
          @user = current_user
          UserLog.create(user_id: current_user.id, note: "өөрийн мэдээллийг xapcaн.")
        else
          UserLog.create(u_id: params[:id], user_id: current_user.id, note: "мэдээлэл xapaхыг оролдсон.")
          redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
        end
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def new
    if current_user
      if current_user.role.en == "admin"
        @user = User.new
        UserLog.create(user_id: current_user.id, note: "шинэ хэрэглэгч нэмэх цонх руу хандсан.")
      else
        UserLog.create(user_id: current_user.id, note: "шинэ хэрэглэгч нэмэх цонх руу хандаxыг оролдсон.")
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      UserLog.create(note: "Бүртгэлгүй эсвэл идэвхтэй хугацаа нь дууссан этгээд шинэ хэрэглэгч нэмэх цонх руу хандаxыг оролдсон.")
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def create
    if current_user
      if current_user.role.en == "admin"
        @user = User.new(admin_params)
        if @user.save
         redirect_to @user, notice: t('message.success')
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
  		if current_user.role.en == "admin"
  			@user = User.find(params[:id])
  		else
  			@user = current_user
      end
  	else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
  	end
  end

	def update
		if current_user
			if current_user.role.en=="admin"
				@user = User.find(params[:id])
				if @user.update(admin_params)
          redirect_to @user, flash: {notice: t('message.success')}
				else
					redirect_to :back, flash: {alert: @user.errors}
				end
      else
        @user = User.find(params[:id])
        if @user.update(user_params)
          redirect_to @user, flash: {notice: t('message.success')}
        else
          redirect_to :back, flash: {alert: @user.errors}
        end
			end
		else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
		end
	end


  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :name, :address, :phone, :phone2, :password, :image)
    end

    def admin_params
      params.require(:user).permit(:email, :name, :address, :phone, :phone2, :role_id, :password, :branch_id, :image)
    end
end
