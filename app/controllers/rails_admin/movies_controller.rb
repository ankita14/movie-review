module RailsAdmin

class MoviesController < RailsAdmin::MainController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  skip_before_filter :get_model
  skip_before_filter :get_object
  skip_before_filter :check_for_cancel
  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # def new
  #   puts "--------------------RRRRRRRRRRRR"
  #   puts "111111111"
  #   puts params[:fetched]
  #   puts "111111111"
  #   if(params[:fetched])
  #     @v = @@mdata
  #   end
  #   puts "--------------------RRRRRRRRRRRR"
  #   @movie = Movie.new
  # end

  # # GET /movies/1/edit
  # def edit
  # end

  # # POST /movies
  # # POST /movies.json
  # def create
  #   # m = Mechanize.new
  #   # page = m.get(movie_params[:url])
  #   @movie = Movie.new(fetched_params)
  #   # @movie.title = page.title
  #   # @movie.director = page.at('.credit_summary_item .itemprop').text
  #   # @movie.stars = page.at('.credit_summary_item h4').text

  #   respond_to do |format|
  #     if @movie.save
  #       @@madat = ''
  #       format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
  #       format.json { render :show, status: :created, location: @movie }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @movie.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  

  def moviedata
  #   m = Mechanize.new
  #   page = m.get(movie_params[:url])
  #   puts "--------------------"
  #   puts page.title
  #   puts "--------------------"
  #   @@mdata = page
  #   redirect_to new_movie_path(:fetched => 'yes')
  #   # head :ok
  end

  # GET /movies/new
  def new
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
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :description, :movie_length, :director, :rating, :admin_id, :image)
    end
end
