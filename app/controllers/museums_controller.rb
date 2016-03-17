class MuseumsController < FrontEndController
  before_action :set_museum, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize, only: [:show, :index]

  # GET /museums
  # GET /museums.json
  def index
    @museums = Museum.all
    @hash = Gmaps4rails.build_markers(@museums) do |museum, marker|
      marker.json({
        :lat => museum.latitude,
        :lng => museum.longitude,
        :custom_infowindow => "<p class='infobox'><h2>" + museum.name + "</h2>" +  museum.description + "</p>"
      })
    end
  end

  def gmap4rails_title
    "something"
  end

  # GET /museums/1
  # GET /museums/1.json
  def show
    @museum = Museum.find params[:id]
    @exhibitions = @museum.exhibitions
  end

  # GET /museums/new
  def new
    @museum = Museum.new
  end

  # GET /museums/1/edit
  def edit
  end

  # POST /museums
  # POST /museums.json
  def create
    @museum = Museum.new(museum_params)

    respond_to do |format|
      if @museum.save
        format.html { redirect_to @museum, notice: 'Museum was successfully created.' }
        format.json { render :show, status: :created, location: @museum }
      else
        format.html { render :new }
        format.json { render json: @museum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /museums/1
  # PATCH/PUT /museums/1.json
  def update
    respond_to do |format|
      if @museum.update(museum_params)
        format.html { redirect_to @museum, notice: 'Museum was successfully updated.' }
        format.json { render :show, status: :ok, location: @museum }
      else
        format.html { render :edit }
        format.json { render json: @museum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /museums/1
  # DELETE /museums/1.json
  def destroy
    @museum.destroy
    respond_to do |format|
      format.html { redirect_to museums_url, notice: 'Museum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_museum
      @museum = Museum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def museum_params
      params.require(:museum).permit(:img_path, :description, :date_created, :name, :longitude, :latitude, :address)
    end
end
