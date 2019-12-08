class UsersController < ApplicationController
  before_action :require_user_logged_in, only:[:index,:show]
  before_action :set_user, only:[:show,:edit,:update,:destroy]


  def index
    @users = User.all.order('created_at DESC').page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] ='User Created!'
      redirect_to users_path
    else
      flash[:danger] ='Failed..'
      render 'new'
    end
  end

  def show
    @scores = @user.scores.order('total_score ASC').limit(10)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] ='Edit information'
      redirect_to user_path(@user.id)
    else
      flash[:danger] ='Failed..'
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:danger] ='Deleted..'
    redirect_to root_path
  end

  private 

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
