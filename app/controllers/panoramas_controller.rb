class PanoramasController < ApplicationController
  before_action :set_panorama, only: [:show, :edit, :update, :destroy]

  # GET /panoramas
  # GET /panoramas.json
  def index
    @panoramas = Panorama.all
  end

  # GET /panoramas/1
  # GET /panoramas/1.json
  def show
  end

  # GET /panoramas/new
  def new
    @panorama = Panorama.new
  end

  # GET /panoramas/1/edit
  def edit
  end

  # POST /panoramas
  # POST /panoramas.json
  def create
    @panorama = Panorama.new(panorama_params)

    respond_to do |format|
      if @panorama.save
        format.html { redirect_to @panorama, notice: 'Panorama was successfully created.' }
        format.json { render :show, status: :created, location: @panorama }
      else
        format.html { render :new }
        format.json { render json: @panorama.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /panoramas/1
  # PATCH/PUT /panoramas/1.json
  def update
    respond_to do |format|
      if @panorama.update(panorama_params)
        format.html { redirect_to @panorama, notice: 'Panorama was successfully updated.' }
        format.json { render :show, status: :ok, location: @panorama }
      else
        format.html { render :edit }
        format.json { render json: @panorama.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /panoramas/1
  # DELETE /panoramas/1.json
  def destroy
    @panorama.destroy
    respond_to do |format|
      format.html { redirect_to panoramas_url, notice: 'Panorama was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_panorama
      @panorama = Panorama.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def panorama_params
      params.require(:panorama).permit(:name)
    end
end
