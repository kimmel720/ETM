class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :addContent]
  skip_before_action :authorize, only: [:show, :index, :new, :create, :addContent]

  # GET /users
  # GET /users.json
  def index
    @users = User.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    user_params[:admin] ||= false
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: "User #{@user.name} was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: "User #{@user.name} was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def addContent
    file = params[:file]
    content = file.read
    puts "*****************#{file.content_type}"
    if file.content_type == 'application/json'
      raw_data = JSON.parse(content)
    elsif file.content_type == 'text/xml'
      raw_data = Hash.from_xml(content)
    end
    @saved_data = raw_data

    # @content = {}

    @saved_data["museums"].each do |museum|
      current_museum = Museum.new(
        user: @user,
        name: museum["name"],
        latitude: museum["latitude"],
        longitude: museum["longitude"],
        street_address: museum["street_address"],
        city: museum["city"],
        country: museum["country"],
        description: museum["description"],
        website: museum["website"],
        color: museum["color"]
      )
      if !current_museum.save
        puts "unable to save museum: #{current_museum.name}"
        # render action: 'addContent', notice: "unable to save museum: #{current_museum.name}"
        museum["name"] = "Unable to save museum: #{museum["name"]}"
      else
        # @content[]

        museum["exhibitions"].each do |exhibition|
          current_exhibition = Exhibition.new(
            user: @user,
            museum: current_museum,
            name: exhibition["name"],
            start_date: Date.strptime(exhibition["start_date"], "%Y, %m, %d"),
            end_date: Date.strptime(exhibition["end_date"], "%Y, %m, %d"),
            description: exhibition["description"],
            curator: exhibition["curator"],
          )
          if !current_exhibition.save
            puts "unable to save exhibition: #{current_exhibition.name}"
            # render action: 'addContent', notice: "unable to save exhibition: #{current_exhibition.name}"
            exhibition["name"] = "Unable to save exhibition: #{exhibition["name"]}"
          else
            # @exhibitions << current_exhibition.name

            exhibition["artworks"].each do |artwork|
              current_artwork = Artwork.new(
                name: artwork["name"],
                exhibition: current_exhibition,
                medium: artwork["medium"],
                description: artwork["description"],
                date_created: Date.strptime(artwork["date_created"], "%Y, %m, %d"),
                accession_no: artwork["accession_no"],
                image_id: 0
              )

              artwork["artists"].each do |artist|
                current_artist = Artist.create(
                  name: artist["name"]
                )
                if !current_artist.save
                  puts "unable to save artist: #{current_artist.name}"
                  # render action: 'addContent', notice: "unable to save artist: #{current_artist.name}"
                  artist["name"] = "Unable to save artist: #{artist["name"]}"
                else
                  # @artists << current_artist.name
                  current_artwork.artists << current_artist
                end

              end
              if !current_artwork.save
                puts "unable to save artwork: #{current_artwork.name}"
                # render action: 'addContent', notice: "unable to save artwork: #{current_artwork.name}"
                artwork["name"] = "Unable to save artwork: #{artwork["name"]}"
              else
                # @artworks << current_artwork.name
              end
            end
          end
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
