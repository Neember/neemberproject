class UsersController < ApplicationController
  def index
    @users = User.all.paginate(page: page)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_param)
    if @user.save
      redirect_to users_path, notice: t('user.message.create_success')
    else
      flash[:alert] = t('user.message.create_failed')
      render :new
    end
  end

  def edit
    @user = User.find(user_id)
  end

  def update
    @user = User.find(user_id)
    if @user.update(user_param)
      redirect_to users_path, notice: t('user.message.update_success')
    else
      flash[:alert] = t('user.message.update_failed')
      render :edit
    end
  end

  def destroy
    @user = User.find(user_id)
    if @user.destroy
      redirect_to users_path, notice: t('user.message.delete_success')
    else
      flash[:alert] = t('user.message.delete_failed')
      render :index
    end
  end

  protected
  def page
    params[:page]
  end

  def user_id
    params.require(:id)
  end

  def user_param
    params.require(:user).permit(:first_name, :last_name, :email, :encrypted_password, :is_admin)
  end
end
