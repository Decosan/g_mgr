class ScoresController < ApplicationController
  before_action :set_score, only:[:show,:edit,:update,:destroy]
  before_action :tag_cloud, only:[:index]

  def index
    @search_params = user_search_params
    @scores = current_user.scores.search(@search_params).includes(:course)
    if params[:tag_name]
      @scores = current_user.scores.tagged_with("#{params[:tag_name]}").page(params[:page])
    end
  end

  def show
    @comment = Comment.new
    @comments = Comment.all.order('created_at DESC')
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

  def tag
    @search_params = user_search_params
    @scores = current_user.scores.tagged_with(params[:id])
    @tags = current_user.scores.tag_counts_on(:tags)
    render :action => 'index'
  end

  private

  def user_search_params
    params.fetch(:search, {}).permit(:total_score_from, :total_score_to,:play_day_from, :play_day_to, :course_id)
  end

  def tag_search_params
    params.fetch(:search, {}).permit(:tag_list)
  end

  def tag_cloud
    # order('count DESC')でカウントの多い順にタグを並べています
    @tags = current_user.scores.tag_counts_on(:tags).order('count DESC')
  end

  def score_params
    params.require(:score).permit(:play_day,:in_score,:out_score,:total_score,:in_put,:out_put,:total_put,:course_id, :tag_list, images: [])
  end

  def set_score
    @score = Score.find(params[:id])
  end
end
