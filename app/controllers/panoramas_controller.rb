class PanoramasController < ApplicationController
  autocomplete :artwork, :name

  before_action :set_panorama

  # POST /panoramas
  def create
  end

  # GET /panoramas/new
  def new
  end

  # GET /panoramas/1/edit
  def edit
    gon.image = Refile.attachment_url(@panorama, :image, :fill, 2048, 512, format: "png")
    gon.id = @panorama.id
  end

  # GET /panoramas/1
  def show
    gon.image = Refile.attachment_url(@panorama, :image, :fill, 2048, 512, format: "png")
    gon.art_array = @panorama.coordinates
    gon.pan_array = @panorama.adjacent_panoramas.map { |adj| transition_panorama_path(adj) }

    # gon.art_array = [
    #     [20, 20, 5, 70, 15, 5, 0.26, 'http://localhost:3000/museums/33/exhibitions/78/artworks/64/']
    # ]
    #
    # gon.pan_array = [
    #     [12, 17, 4, -70, 2, 5, 0, 'http://localhost:3000/panoramas/1/transition']
    # ]

    @crumbs = [
      [@museum.name, museum_path(@museum)],
      [@exhibition.name, museum_exhibition_path(@museum,@exhibition)],
      ["Panorama", panorama_path(@museum,@exhibition,@panorama)]
    ]
  end

  # TODO: merge transition with show -- just need to add format.json option and
  # ask nicely for it in ajax request
  # GET /panoramas/1/transition
  def transition
    art_array = [
        [20, 20, 5, 70, 15, 5, 0.26, 'http://localhost:3000/museums/33/exhibitions/78/artworks/64/']
    ]

    pan_array = [
        [12, 17, 4, -70, 2, 5, 0, 'http://localhost:3000/panoramas/1/transition']
    ]

    respond_to do |format|
      format.json do
        render json: {
          image: Refile.attachment_url(@panorama, :image, :fill, 2048, 512, format: "png"),
          art_array: art_array,
          pan_array: pan_array
        }.to_json
      end
    end
  end

  # POST /panoramas/:id/add_art/:art_id
  def add_artwork
    @panorama.coordinates[params[:art_id]] = [params[:x], params[:y], params[:z], params[:r], artwork_path(params[:art_id])]
    @panorama.save

    render :nothing => true
  end

  # POST /panoramas/:id/add_adj/:pan_id
  def add_adjacent_panorama
    @adjacent = Panorama.find(params[:adj_id])
    @panorama.adjacent_panoramas << @adjacent
    @panorama.save
    render :nothing => true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_panorama
      @panorama = Panorama.find(params[:id])
      @exhibition = @panorama.exhibition
      @museum = @exhibition.museum
      @artworks = @exhibition.artworks
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def panorama_params
      params.require(:panorama).permit(:show)
    end
end
