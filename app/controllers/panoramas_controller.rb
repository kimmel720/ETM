class PanoramasController < ApplicationController
  before_action :set_panorama, only: [:show]

  # GET /panoramas/1
  # GET /panoramas/1.json
  def show
    gon.image = Refile.attachment_url(@panorama, :image, :fill, 2048, 512, format: "png")
    gon.art_array = @panorama.artwork_coordinates
    gon.pan_array = @panorama.adjacent_panoramas

    @crumbs = [
      [@museum.name, museum_path(@museum)],
      [@exhibition.name, museum_exhibition_path(@museum,@exhibition)],
      ["Panorama", panorama_museum_exhibition_path(@museum,@exhibition,@panorama)]
    ]

    respond_to do |format|
      format.json { render :json => @panorama }
      format.html
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
