class FloorPlansController < ApplicationController
  before_action :set_floor_plan, only: [:show, :edit, :update, :destroy]

  # GET /floor_plans
  # GET /floor_plans.json
  def index
    @floor_plans = FloorPlan.all
  end

  # GET /floor_plans/1
  # GET /floor_plans/1.json
  def show
  end

  # GET /floor_plans/new
  def new
    @floor_plan = FloorPlan.new
  end

  # GET /floor_plans/1/edit
  def edit
  end

  # POST /floor_plans
  # POST /floor_plans.json
  def create
    @floor_plan = FloorPlan.new(floor_plan_params)

    respond_to do |format|
      if @floor_plan.save
        format.html { redirect_to @floor_plan, notice: 'Floor plan was successfully created.' }
        format.json { render :show, status: :created, location: @floor_plan }
      else
        format.html { render :new }
        format.json { render json: @floor_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /floor_plans/1
  # PATCH/PUT /floor_plans/1.json
  def update
    respond_to do |format|
      if @floor_plan.update(floor_plan_params)
        format.html { redirect_to @floor_plan, notice: 'Floor plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @floor_plan }
      else
        format.html { render :edit }
        format.json { render json: @floor_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /floor_plans/1
  # DELETE /floor_plans/1.json
  def destroy
    @floor_plan.destroy
    respond_to do |format|
      format.html { redirect_to floor_plans_url, notice: 'Floor plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_floor_plan
      @floor_plan = FloorPlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def floor_plan_params
      params.require(:floor_plan).permit(:name)
    end
end
