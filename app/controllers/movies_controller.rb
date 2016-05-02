class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  def new   
    if(params[:fetched])
      @v = @@mdata
    end  
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)
    respond_to do |format|
      if @movie.save
        @@madat = ''
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def bollywood_hungama    
    redirect_to rails_admin.new_path(model_name: 'movie',:fetched=>url_params[:url] )
  end

  def latest_movie
    
  end

  # GET /movies/new
  # def new
  #   @movie = Movie.new
  # end

  # # GET /movies/1/edit
  # def edit
  # end

  # POST /movies
  # POST /movies.json
  # def create
  #   @movie = Movie.new(movie_params)

  #   respond_to do |format|
  #     if @movie.save
  #       format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
  #       format.json { render :show, status: :created, location: @movie }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @movie.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def mov_with_critic
    
    @movie = Movie.new(movie_params)
    @critics_ratings = CriticsRating.new(critics_params)
    if @movie.save && @critics_ratings.save
      redirect_to rails_admin.dashboard_path
    else
      render :new 
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def url_params
      params.require(:movie).permit(:url)
    end

      # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :description, :movie_reviews, :director, :producer, :music_director, :star_cast, :release_date, :movie_length, :youtube_url, :admin_id, :image)
    end

    def critics_params
      params.require(:cr).permit(:title, :rating, :reviews)
      
    end
end
