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
      flash[:danger] ='failed..'
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private 

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  # def correct_user
  #   unless logged_in? 
  #     redirect_to new_session_path
  #   end
  # end
end
