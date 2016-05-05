class ArtworksController < FrontEndController
  before_action :set_artwork, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize, only: [:show, :index, :update]

  # GET /artworks
  # GET /artworks.json
  def index
    @artworks = Artwork.all
  end

  # GET /artworks/1
  # GET /artworks/1.json
  def show
    @crumbs = [
      [@museum.name, museum_path(@museum)],
      [@exhibition.name, museum_exhibition_path(@museum,@exhibition)],
      [@artwork.name, artwork_path(@museum,@exhibition,@artwork)]
    ]
    gon.colorcode = @museum.color
    respond_to do |format|
      format.js
      format.html { render :show }
    end
  end

  # GET /artworks/new
  def new
    @artwork = Artwork.new
  end

  # GET /artworks/1/edit
  def edit
    @crumbs = [
      [@museum.name, museum_path(@museum)],
      [@exhibition.name, museum_exhibition_path(@museum,@exhibition)],
      [@artwork.name, artwork_path(@artwork)],
      ["Edit Artwork", edit_artwork_path(@artwork)]
    ]
    gon.colorcode = @museum.color
  end

  # POST /artworks
  # POST /artworks.json
  def create
    @artwork = Artwork.new(artwork_params)

    respond_to do |format|
      if @artwork.save
        format.html { redirect_to @artwork, notice: 'Artwork was successfully created.' }
        format.json { render :show, status: :created, location: @artwork }
      else
        format.html { render :new }
        format.json { render json: @artwork.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artworks/1
  # PATCH/PUT /artworks/1.json
  def update
    respond_to do |format|
      if @artwork.update(artwork_params)
        format.html { redirect_to artwork_path(@artwork), notice: 'Artwork was successfully updated.' }
        format.json { render :nothing => true }
      else
        format.html { render :edit }
        format.json { render :nothing => true }
      end
    end
  end

  # DELETE /artworks/1
  # DELETE /artworks/1.json
  def destroy
    @artwork.destroy
    respond_to do |format|
      format.html { redirect_to artworks_url, notice: 'Artwork was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artwork
      @artwork = Artwork.find(params[:id])
      @artists = @artwork.artists
      @exhibition = @artwork.exhibition
      @museum = @exhibition.museum
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artwork_params
      params.require(:artwork).permit(:img, :image, :description, :date_created, :left, :right, :top, :bottom)
    end
end
