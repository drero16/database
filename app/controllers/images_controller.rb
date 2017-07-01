class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :animal
  load_and_authorize_resource :pet
  load_and_authorize_resource :risk
  load_and_authorize_resource :adoption
  load_and_authorize_resource :event
  load_and_authorize_resource :information
  load_and_authorize_resource :user
  load_and_authorize_resource :comment, :through => [:animal,:pet,:risk,:adoption,:event,:information,:user]
  # GET /images
  # GET /images.json
  def index
    @images = Image.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)
    respond_to do |format|
      if @image.save
        format.json { render :json => { url: @image.image.url} }
      else
        
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to :back, notice: 'Imagen actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Imagen eliminada correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:link, :animal_id, :pet_id,:risk_id,:adoption_id, :event_id, :information_id, :user_id,:image, :image_file_name, :image_content_type, :image_file_size, :image_updated_at)
    end
end
