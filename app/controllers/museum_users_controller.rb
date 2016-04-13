class MuseumUsersController < ApplicationController
  before_action :set_museum_user, only: [:show, :edit, :update, :destroy]

  # GET /museum_users
  # GET /museum_users.json
  def index
    @museum_users = MuseumUser.all
  end

  # GET /museum_users/1
  # GET /museum_users/1.json
  def show
  end

  # GET /museum_users/new
  def new
    @museum_user = MuseumUser.new
  end

  # GET /museum_users/1/edit
  def edit
  end

  # POST /museum_users
  # POST /museum_users.json
  def create
    @museum_user = MuseumUser.new(museum_user_params)

    respond_to do |format|
      if @museum_user.save
        format.html { redirect_to @museum_user, notice: 'Museum user was successfully created.' }
        format.json { render :show, status: :created, location: @museum_user }
      else
        format.html { render :new }
        format.json { render json: @museum_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /museum_users/1
  # PATCH/PUT /museum_users/1.json
  def update
    respond_to do |format|
      if @museum_user.update(museum_user_params)
        format.html { redirect_to @museum_user, notice: 'Museum user was successfully updated.' }
        format.json { render :show, status: :ok, location: @museum_user }
      else
        format.html { render :edit }
        format.json { render json: @museum_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /museum_users/1
  # DELETE /museum_users/1.json
  def destroy
    @museum_user.destroy
    respond_to do |format|
      format.html { redirect_to museum_users_url, notice: 'Museum user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_museum_user
      @museum_user = MuseumUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def museum_user_params
      params.fetch(:museum_user, {})
    end
end
