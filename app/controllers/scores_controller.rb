class ScoresController < ApplicationController
  before_action :set_score, only:[:show,:edit,:update,:destroy]
  before_action :tag_cloud, only:[:index]

  def index  
    if params[:score] && params[:score][:search]
      if params[:score][:tag_search].present?
        @scores = current_user.scores.tagged_with([params[:tag_search]], :any => true).page(params[:page])
      end
    else
      if params[:tag_name]
        @scores = current_user.scores.tagged_with("#{params[:tag_name]}").page(params[:page])
      elsif params[:sort_scores]
        @scores =  current_user.scores.order('total_score ASC').page(params[:page])
      else
        @scores = current_user.scores.all.order('play_day DESC').page(params[:page])
      end
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
    @scores = current_user.scores.tagged_with(params[:id])
    @tags = current_user.scores.tag_counts_on(:tags)
    render :action => 'index'
  end

  def search
    @search_params = score_search_params  #検索結果の画面で、フォームに検索した値を表示するために、paramsの値をビューで使えるようにする
    @scores = Score.search(@search_params).joins(:customer)  #scoreモデルのsearchを呼び出し、引数としてparamsを渡している。
  end

  private

  def score_search_params
    params.fetch(:search, {}).permit(:name_kana, :play_day_from, :play_day_to)
    #fetch(:search, {})と記述することで、検索フォームに値がない場合はnilを返し、エラーが起こらなくなる
    #ここでの:searchには、フォームから送られてくるparamsの値が入っている
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
