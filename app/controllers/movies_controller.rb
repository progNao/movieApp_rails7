class MoviesController < ApplicationController
  before_action :authenticate_user!

  $movie_genres = [["アクション", "アクション"], ["コメディ", "コメディ"], ["ドラマ", "ドラマ"],
    ["ホラー", "ホラー"], ["サイエンスフィクション", "サイエンスフィクション"], ["ロマンス", "ロマンス"],
    ["ファンタジー", "ファンタジー"], ["ミステリー", "ミステリー"], ["スリラー", "スリラー"],
    ["アニメ", "アニメ"]]
  
  def index
    if Movie.where(user_id: current_user.id)
      @q = Movie.ransack(params[:q])
      @movies = @q.result(distinct: true).where(is_delete: false, user_id: current_user.id)
    else
      @movies = []
    end
  end
  
  def new
    @movie = Movie.new
    @genres = $movie_genres
  end
  
  def create
    @movie = Movie.new(permit_params.merge(user_id: current_user.id))
    @movie.image == params[:movie][:image].read
    @movie.is_delete = false
    if @movie.save
      flash[:notice] = "映画を登録しました!"
      redirect_to movies_path
    else
      flash.now[:alert] = "映画を登録できませんでした..."
      @genres = $movie_genres
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @movie = Movie.find(params[:id])
    @genres = $movie_genres
  end
  
  def update
    @movie = Movie.find(params[:id])
    @movie.image == params[:movie][:image].read
    @movie.is_delete = false
    if @movie.update(permit_params.merge(user_id: current_user.id))
      flash[:notice] = "映画を更新しました!"
      redirect_to movies_path
    else
      flash.now[:alert] = "映画を更新できませんでした..."
      @genres = $movie_genres
      render :edit, status: :unprocessable_entity
    end
  end
  
  def delete_update
    @movie = Movie.find_by(id: params[:id], user_id: current_user.id)
    if @movie.update(is_delete: true)
      flash[:alert] = "映画を削除しました."
      redirect_to movies_path
    else
      flash[:alert] = "映画を削除できませんでした..."
      render :index, status: :unprocessable_entity
    end
  end
  
  private

  def permit_params
    params.require(:movie).permit(:title, :description, :genre, :is_delete, :evaluation, :image)
  end
end
