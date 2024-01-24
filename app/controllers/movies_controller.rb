class MoviesController < ApplicationController
  def index
    if Movie.where(user_id: current_user.id)
      @movies = Movie.where(is_delete: false, user_id: current_user.id)
    else
      @movies = []
    end
  end
  
  def new
    @movie = Movie.new
  end
  
  def create
    @movie = Movie.new(permit_params.merge(user_id: current_user.id))
    @movie.image == params[:movie][:image].read
    @movie.is_delete = false
    if @movie.save!
      flash[:notice] = "You could create movie!"
      redirect_to movies_path
    else
      flash.now[:alert] = "Could not create movie..."
      render :new
    end
  end
  
  def edit
    @movie = Movie.find(params[:id])
  end
  
  def update
    @movie = Movie.find(params[:id])
    @movie.image == params[:movie][:image].read
    @movie.is_delete = false
    if @movie.update!(permit_params.merge(user_id: current_user.id))
      flash[:notice] = "You could update movie!"
      redirect_to movies_path
    else
      flash.now[:alert] = "Could not update movie..."
      render :edit
    end
  end
  
  def delete_update
    @movie = Movie.find_by(id: params[:id], user_id: current_user.id)
    if @movie.update(is_delete: true)
      flash[:notice] = "You could delete movie."
      redirect_to movies_path
    else
      flash[:alert] = "Could not delete movie..."
      render :index
    end
  end
  
  private

  def permit_params
    params.require(:movie).permit(:title, :description, :genre, :is_delete, :evaluation, :image)
  end
end
