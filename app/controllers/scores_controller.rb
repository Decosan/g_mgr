class ScoresController < ApplicationController
  before_action :set_score, only:[:show,:edit,:update,:destroy]

  def index
    @scores = Score.all.order('created_at DESC').page(params[:page])
  end

  def show
    @courses = Course.all
  end

  def new
    @score = Score.new
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
  end

  def update
  end

  def destroy
  end

  private

  def score_params
    params.require(:score).permit(:play_day,:in_score,:out_score,:total_score,:in_put,:out_put,:total_put,:course_id, images: [])
  end

  def set_score
    @score = Score.find(params[:id])
  end
end
