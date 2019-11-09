class UsersController < ApplicationController
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
      redirect_to :index
    else
      flash[:danfer] ='failed..'
      render 'new'
    end
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
end
