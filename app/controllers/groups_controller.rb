class GroupsController < ApplicationController
  before_action :set_group, only:[:edit,:update,:destroy,:show]

  def index
    @groups = Group.order('created_at DESC').page(params[:page])
  end

  def show
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user_id = current_user.id
    if @group.save
      current_user.user_groups.create(group_id: @group.id)
      flash[:success] ='新規グループを作成しました'
      redirect_to groups_path
    else
      flash[:danger] ='失敗しました。。'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash[:success] ='グループデータを更新しました' 
      redirect_to groups_path
    else
      flash[:danger] ='失敗しました。。'
      render 'edit'
    end
  end

  def destroy
    @group.destroy
    flash[:danger] ='グループを削除しました'
    redirect_to groups_path
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name)
  end
end
