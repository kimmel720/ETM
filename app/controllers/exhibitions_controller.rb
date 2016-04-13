class ExhibitionsController < FrontEndController
  before_action :set_exhibition, only: [:show, :edit, :update, :destroy, :floor_plan, :panorama, :resources]
  skip_before_action :authorize, only: [:show, :index, :floor_plan, :panorama, :resources]

  # GET /exhibitions
  # GET /exhibitions.json
  def index
    @museum = Museum.find params[:museum_id]
    @exhibitions = Exhibition.all
  end

  # GET /exhibitions/1
  # GET /exhibitions/1.json
  def show
    @crumbs = [
      [@museum.name, museum_path(@museum)],
      [@exhibition.name, museum_exhibition_path(@museum,@exhibition)]
    ]
    gon.datasetartwork = @artworks.each.map{ |a| {
      id: a.id,
      content: a.name,
      start: a.date_created.strftime('%Y-%m-%d')
      }}
    respond_to do |format|
      format.js
      format.html { render :show }
    end
  end

  # GET /exhibitions/new
  def new
    @exhibition = Exhibition.new
  end

  # GET /exhibitions/1/edit
  def edit
  end

  # POST /exhibitions
  # POST /exhibitions.json
  def create
    @exhibition = Exhibition.new(exhibition_params)

    respond_to do |format|
      if @exhibition.save
        format.html { redirect_to @exhibition, notice: 'Exhibition was successfully created.' }
        format.json { render :show, status: :created, location: @exhibition }
      else
        format.html { render :new }
        format.json { render json: @exhibition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exhibitions/1
  # PATCH/PUT /exhibitions/1.json
  def update
    respond_to do |format|
      if @exhibition.update(exhibition_params)
        format.html { redirect_to @exhibition, notice: 'Exhibition was successfully updated.' }
        format.json { render :show, status: :ok, location: @exhibition }
      else
        format.html { render :edit }
        format.json { render json: @exhibition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exhibitions/1
  # DELETE /exhibitions/1.json
  def destroy
    @exhibition.destroy
    respond_to do |format|
      format.html { redirect_to exhibitions_url, notice: 'Exhibition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def floor_plan
    floor_data = [
      ["http://www.google.com/" , "356,129,385,187"],
      ["https://www.youtube.com/" , "71,97,101,154"],
      ["http://www.isitajewishholidaytoday.com/", "102,261,133,283"]
    ]
    gon.floor_data = floor_data
  end

  def resources
  end

  def panorama
    @panoramas = @exhibition.panoramas
    pid = params[:panorama_id]
    if pid
      @panorama = @panoramas.find(pid)
    else
      @panorama = @panoramas.first
    end
    @crumbs = [
      [@museum.name, museum_path(@museum)],
      [@exhibition.name, museum_exhibition_path(@museum,@exhibition)],
      ["Panorama", panorama_museum_exhibition_path(@museum,@exhibition,@panorama)]
    ]

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exhibition
      @exhibition = Exhibition.find(params[:id])
      @museum = @exhibition.museum
      @artworks = @exhibition.artworks
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exhibition_params
      params.require(:exhibition).permit(:img_path, :description, :date_created, :museum_id)
    end
end
