class PanoramasController < ApplicationController
  before_action :set_panorama

  # GET /panoramas/1
  def show
    gon.art_array = @panorama.artwork_coordinates
    gon.pan_array = @panorama.adjacent_panoramas.map { |adj| transition_path(adj) }
    gon.image = Refile.attachment_url(@panorama, :image, :fill, 2048, 512, format: "png")

    @crumbs = [
      [@museum.name, museum_path(@museum)],
      [@exhibition.name, museum_exhibition_path(@museum,@exhibition)],
      ["Panorama", panorama_museum_exhibition_path(@museum,@exhibition,@panorama)]
    ]

  end

  # POST /panoramas/1
  def transition
    respond_to do |format|
      format.json do
        render json: {
          image: Refile.attachment_url(@panorama, :image, :fill, 2048, 512, format: "png"),
          art_array: @panorama.artwork_coordinates,
          pan_array: @panorama.adjacent_panoramas.map { |adj| transition_path(adj) }
        }.to_json
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_panorama
      @panorama = Panorama.find(params[:id])
      @exhibition = @panorama.exhibition
      @museum = @exhibition.museum
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def panorama_params
      params.require(:panorama).permit(:show)
    end
end
