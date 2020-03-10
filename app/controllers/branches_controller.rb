class BranchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_branch, only: [:show, :edit, :update]

  def index
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "nyarav" or current_user.role.en == "seller" or current_user.role.en == "nyabo"
        @branches = Branch.all
      else
        BranchLog.create(user_id: current_user.id, note: "салбарууд цонхруу хандаxыг оролдсон.")
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end


  def show
    if current_user
      if current_user.role.en == "admin" or current_user.role.en == "nyabo"
        @branch = Branch.find(params[:id])
        @users = User.where(branch_id: (params[:id]))
        BranchLog.create(branch_id: @branch.id, user_id: current_user.id, name: @branch.name, address: @branch.address, note: "салбарын мэдээллийг xapcaн.")
      elsif current_user.role.en == "seller"
        @branch = Branch.find_by_id(current_user.branch_id)
        @users = User.where(branch_id: (params[:id]))
        BranchLog.create(branch_id: @branch.id, user_id: current_user.id, name: @branch.name, address: @branch.address, note: "өөрийн салбарын мэдээллийг xapcaн.")
      elsif current_user.role.en == "nyarav"
        @branch = Branch.find_by_id(current_user.branch_id)
        @users = User.where(branch_id: current_user.branch_id)
        BranchLog.create(branch_id: @branch.id, user_id: current_user.id, name: @branch.name, address: @branch.address, note: "өөрийн салбарын мэдээллийг xapcaн.")
      else
        BranchLog.create(branch_id: @branch.id, user_id: current_user.id, name: @branch.name, address: @branch.address, note: "салбарын мэдээллийг xapaxыг оролдсон.")
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end


  def new
    if current_user
      if current_user.role.en == "admin"
        @branch = Branch.new
        BranchLog.create(user_id: current_user.id, note: "шинэ салбар нээх цонх руу хандсан.")
      else
        BranchLog.create(user_id: current_user.id, note: "шинэ салбар нээх цонх руу хандаxыг оролдсон.")
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      BranchLog.create(note: "Бүртгэлгүй эсвэл идэвхтэй хугацаа нь дууссан этгээд шинэ салбар нээх цонх руу хандаxыг оролдсон.")
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def edit
    if current_user
      if current_user.role.en == "admin"
        @branch = Branch.find(params[:id])
        BranchLog.create(branch_id: @branch.id, user_id: current_user.id, name: @branch.name, address: @branch.address, note: "салбарын мэдээллийг өөрчилөx цонх руу хандсан.")
      else
        BranchLog.create(branch_id: @branch.id, user_id: current_user.id, name: @branch.name, address: @branch.address, note: "салбарын мэдээллийг өөрчилөхийг оролдсон.")
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      BranchLog.create(note: "Бүртгэлгүй эсвэл идэвхтэй хугацаа нь дууссан этгээд салбарын мэдээллийг өөрчилөхийг оролдсон.")
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def create
    if current_user
      if current_user.role.en == "admin"
        @branch = Branch.new(branch_params)
        if @branch.save
          BranchLog.create(branch_id: @branch.id, user_id: current_user.id, name: @branch.name, address: @branch.address, note: "шинэ салбар бүртгэлээ.")
          redirect_to @branch, notice: t('branch.status.created')
        else
          render :new
        end
      else
        BranchLog.create(user_id: current_user.id, note: "шинэ салбар бүртгэхийг оролдсон.")
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
      BranchLog.create(note: "Бүртгэлгүй эсвэл идэвхтэй хугацаа нь дууссан этгээд шинэ салбар бүртгэхийг оролдсон.")
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  def update
    if current_user
      if current_user.role.en == "admin"
        if @branch.update(branch_params)
          BranchLog.create(branch_id: @branch.id, user_id: current_user.id, name: @branch.name, address: @branch.address, note: "салбарын мэдээллийг болгож шинэчлэсэн.")
          redirect_to @branch, notice: t('branch.status.updated')
        else
          render :edit
        end
      else
        BranchLog.create(branch_id: @branch.id, user_id: current_user.id, name: @branch.name, address: @branch.address, note: "салбарын мэдээллийг болгож шинэчлэхийг оролдсон.")
        redirect_to authenticated_root_path, flash: {alert: t('message.not_found')}
      end
    else
       BranchLog.create(branch_id: @branch.id, user_id: current_user.id, name: @branch.name, address: @branch.address, note: "Бүртгэлгүй эсвэл идэвхтэй хугацаа нь дууссан этгээд салбарын мэдээллийг болгож шинэчлэхийг оролдсон.")
      redirect_to unauthenticated_root_path, flash: {alert: t('message.not_found')}
    end
  end

  private
    def set_branch
      @branch = Branch.find(params[:id])
    end

    def branch_params
      params.require(:branch).permit(:name, :address, :image)
    end
end
