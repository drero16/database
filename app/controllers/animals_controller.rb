class AnimalsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  #before_action :set_animal, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /animals
  # GET /animals.json
  def index
    #@animals = Animal.where(animal_state: 0)
    @animals = Animal.where(nil)
    filtering_params(params).each do |key, value|
      @animals=@animals.public_send(key,value) if value.present?
    end

  end
  # GET /animals/1
  # GET /animals/1.json
  def show
    @comment=Comment.new
    #@comment.animal_id=params[:id]
    #@page= Page.new(params[:page].merge(:user_id => 1, :foo => "bar"))

      #  @comment = Comment.new(comment_params.merge(animal_id: params[:id]))

  end

  # GET /animals/new
  def new
    @animal = Animal.new
  end

  # GET /animals/1/edit
  def edit
  end

  # POST /animals
  # POST /animals.json
  def create
     
    @animal = Animal.new(animal_params)
    @animal.user_id = current_user.id
    @animal.animal_state= 0
  
    respond_to do |format|
      if @animal.save
        if params[:images]
          params[:images].each { |image|
          @animal.images.create(image: image)
        }
        end
        format.html { redirect_to @animal, notice: 'Animal was successfully created.' }
        format.json { render :show, status: :created, location: @animal }
      else
        format.html { render :new }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /animals/1
  # PATCH/PUT /animals/1.json
  def update
    respond_to do |format|
      if @animal.update(animal_params)
        if params[:images]
          params[:images].each { |image|
          @animal.images.create(image: image)
        }
        end
        format.html { redirect_to @animal, notice: 'Animal was successfully updated.' }
        format.json { render :show, status: :ok, location: @animal }
      else
        format.html { render :edit }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /animals/1
  # DELETE /animals/1.json
  def destroy
    @animal.destroy
    respond_to do |format|
      format.html { redirect_to animals_url, notice: 'Animal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def animal_params
      params.require(:animal).permit(:animal_type, :age, :sex, :location, :description, :user_id, :race_id)
    end

    def filtering_params(params)
      params.slice(:animal_type, :sex)
    end

end
