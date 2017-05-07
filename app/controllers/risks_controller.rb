class RisksController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  #before_action :set_risk, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /risks
  # GET /risks.json
  def index
    @risks = Risk.where(animal_state: 1)
  end
  # GET /risks/1
  # GET /risks/1.json
  def show
    @comment=Comment.new
    #@comment.risk_id=params[:id]
    #@page= Page.new(params[:page].merge(:user_id => 1, :foo => "bar"))

      #  @comment = Comment.new(comment_params.merge(risk_id: params[:id]))

  end

  # GET /risks/new
  def new
    @risk = Risk.new
  end

  # GET /risks/1/edit
  def edit
  end

  # POST /risks
  # POST /risks.json
  def create
     
    @risk = Risk.new(risk_params)
    @risk.user_id = current_user.id
    @risk.animal_state= 1
  
    respond_to do |format|
      if @risk.save
        if params[:images]
          params[:images].each { |image|
          @risk.images.create(image: image)
        }
        end
        format.html { redirect_to @risk, notice: 'Risk was successfully created.' }
        format.json { render :show, status: :created, location: @risk }
      else
        format.html { render :new }
        format.json { render json: @risk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /risks/1
  # PATCH/PUT /risks/1.json
  def update
    respond_to do |format|
      if @risk.update(risk_params)
        if params[:images]
          params[:images].each { |image|
          @risk.images.create(image: image)
        }
        end
        format.html { redirect_to @risk, notice: 'Risk was successfully updated.' }
        format.json { render :show, status: :ok, location: @risk }
      else
        format.html { render :edit }
        format.json { render json: @risk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /risks/1
  # DELETE /risks/1.json
  def destroy
    @risk.destroy
    respond_to do |format|
      format.html { redirect_to risks_url, notice: 'Risk was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_risk
      @risk = Risk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def risk_params
      params.require(:risk).permit(:animal_type, :age, :sex, :location, :description, :user_id, :race_id)
    end
end
