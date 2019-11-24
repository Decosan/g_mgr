class ScoresController < ApplicationController
  before_action :set_score, only:[:show,:edit,:update,:destroy]

  def index
    @scores = current_user.scores.all.order('created_at DESC').page(params[:page])
  end

  def show
    @courses = Course.all
    @comment = Comment.new
    @comments = Comment.all.order('created_at DESC')
  end

  def new
    @score = Score.new
    @courses = Course.all
  end

  def create
    @score = current_user.scores.build(score_params)
    if @score.save
      flash[:success] ='Create New score!'
      redirect_to scores_path
    else
      flash[:danger] ='Failed..'
      render 'new'
    end
  end

  def edit
    @courses = Course.all
  end

  def update
    if @score.update(score_params)
      flash[:success] ='Edit Completed!'
      redirect_to score_path(@score.id)
    else
      flash[:danger] ='Failed..'
      render 'edit'
    end
  end

  def destroy
    @score.destroy
    flash[:danger] ='Deleted..'
    redirect_to scores_path
  end

  private

  def score_params
    params.require(:score).permit(:play_day,:in_score,:out_score,:total_score,:in_put,:out_put,:total_put,:course_id, :tag_list, images: [])
  end

  def set_score
    @score = Score.find(params[:id])
  end
end
