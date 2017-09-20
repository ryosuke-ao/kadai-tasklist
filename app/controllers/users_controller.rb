class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :tofavs, :faveds]
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(10)
    @task = Task.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def tofavs
    @user = User.find(params[:id])
    @tasks = @user.tofavs.page(params[:page])
    counts(@user)
    @task = Task.new
  end
  
  def faveds
    @user = User.find(params[:id])
    @followers = @user.faveds.page(params[:page])
    counts(@user)
    @task = Task.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
