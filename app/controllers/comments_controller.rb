class CommentsController < ApplicationController

  def create
    @score = Score.find(params[:score_id])
    @comment = @score.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] ='コメント追加されました。'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] ='失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:danger] ='コメントを削除しました'
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
