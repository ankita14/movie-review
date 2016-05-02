class FeaturedTrailorsController < ApplicationController
  before_action :set_featured_trailor, only: [:show, :edit, :update, :destroy]

  # GET /featured_trailors
  # GET /featured_trailors.json
  def index
    @featured_trailors = FeaturedTrailor.all
  end

  # GET /featured_trailors/1
  # GET /featured_trailors/1.json
  def show
  end

  # GET /featured_trailors/new
  def new
    @featured_trailor = FeaturedTrailor.new
  end

  # GET /featured_trailors/1/edit
  def edit
  end

  # POST /featured_trailors
  # POST /featured_trailors.json
  def create
    @featured_trailor = FeaturedTrailor.new(featured_trailor_params)

    respond_to do |format|
      if @featured_trailor.save
        format.html { redirect_to @featured_trailor, notice: 'Featured trailor was successfully created.' }
        format.json { render :show, status: :created, location: @featured_trailor }
      else
        format.html { render :new }
        format.json { render json: @featured_trailor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /featured_trailors/1
  # PATCH/PUT /featured_trailors/1.json
  def update
    respond_to do |format|
      if @featured_trailor.update(featured_trailor_params)
        format.html { redirect_to @featured_trailor, notice: 'Featured trailor was successfully updated.' }
        format.json { render :show, status: :ok, location: @featured_trailor }
      else
        format.html { render :edit }
        format.json { render json: @featured_trailor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /featured_trailors/1
  # DELETE /featured_trailors/1.json
  def destroy
    @featured_trailor.destroy
    respond_to do |format|
      format.html { redirect_to featured_trailors_url, notice: 'Featured trailor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_featured_trailor
      @featured_trailor = FeaturedTrailor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def featured_trailor_params
      params.require(:featured_trailor).permit(:movie_id, :position)
    end
end
