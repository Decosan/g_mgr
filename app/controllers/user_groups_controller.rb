class UserGroupsController < ApplicationController
  def create
    user_group = current_user.user_groups.create(group_id: params[:group_id])
    flash[:success] ='グループに参加しました'
    redirect_to groups_path
  end

  def destroy
    user_group = current_user.user_groups.find_by(group_id: params[:id])
    user_group.destroy
    flash[:danger] ='グループから退出しました'
    redirect_to groups_path
  end
end
