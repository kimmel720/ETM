class PanoramasController < ApplicationController
  before_action :set_panorama, only: [:show]

  # GET /panoramas/1
  # GET /panoramas/1.json
  def show
    respond_to do |format|
      format.json { render :json => @panorama }
      format.html
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_panorama
      @panorama = Panorama.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def panorama_params
      params.require(:panorama).permit(:show)
    end
end
