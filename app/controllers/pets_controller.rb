class PetsController < ApplicationController
  #before_action :set_pet, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index]
  load_and_authorize_resource

  # GET /pets
  # GET /pets.json
  def index
    @pets =Pet.where(solved: false)
    @pets = @pets.animal_type(params[:animal_type]) if params[:animal_type].present?
    @pets = @pets.sex(params[:sex]) if params[:sex].present?
    @pets = @pets.race(params[:race]) if params[:race].present?
    @pets = @pets.date(params[:date]) if params[:date].present?
#    @pets = @pets.status(params[:status]) if params[:status].present?
    if params[:lost_in].present?
      coords=Geocoder.coordinates(params[:lost_in]) 
      @pets = @pets.near(coords,0.3)
    end

    @pets=@pets.paginate(:page => params[:page], :per_page => 10).order('created_at DESC') if params[:sort]=="Recientes"
    @pets=@pets.paginate(:page => params[:page], :per_page => 10).order('created_at ASC') if params[:sort]=="Antiguos"
    @pets=@pets.paginate(:page => params[:page], :per_page => 10) if params[:sort]=="Cercanía"
    @pets=@pets.paginate(:page => params[:page], :per_page => 10).includes(:race).joins(:race).order('name ASC') if params[:sort]=="Raza"
    @pets=@pets.paginate(:page => params[:page], :per_page => 10).order('sex ASC') if params[:sort]=="Sexo"

  end

  # GET /pets/1
  # GET /pets/1.json
  def show
    @comment=Comment.new
  end

  # GET /pets/new
  def new
    @pet = Pet.new
  end

  # GET /pets/1/edit
  def edit
  end

  # POST /pets
  # POST /pets.json
  def create
    @pet = Pet.new(pet_params)
    @pet.user_id = current_user.id
    @pet.solved= false
  
    respond_to do |format|
      if params[:images].present?
        if @pet.save and params[:images].present?
          if params[:images]
            params[:images].each { |image|
            @pet.images.create(image: image)
          }
          end
          format.html { redirect_to @pet }
          format.json { render :show, status: :created, location: @pet }
 #         coord=Geocoder.coordinates(params[:location]) 
 #         @users_near= User.near(coord,2)
 #         @users_near.each do |near|
 #             unless (near==@pet.user)
 #               user=near
 #               title="Se ha perdido un animal cerca tuyo!"
 #               body= near.location
 #               url= animal_url(@pet)
 #               Notification.create(user: user, titulo: title, mensaje: body, url: url, seen: 0)
 #             end
          else
            unless params[:images].present?
              @pet.errors.add(:images)
            end            
           format.html { render :new }
           format.json { render json: @pet.errors, status: :unprocessable_entity }
          end
      else
        unless params[:images].present?
          @pet.errors.add(:images)
        end
        format.html { render :new }
        format.json { render json: @pet.errors, status: :unprocessable_entity }      
    end
    end
  end

  # PATCH/PUT /pets/1
  # PATCH/PUT /pets/1.json
 def update
   respond_to do |format|
      
      if @pet.update(pet_params)
        if params[:images]
          params[:images].each { |image|
          @pet.images.create(image: image)
        }
        end
        if params[:selected]
          params[:selected].each { |selecte|
            @pet.images.destroy(selecte)
          }
        end
        if pet_params[:solved]
        format.html { redirect_to @pet}
        else
        format.html { redirect_to @pet, notice: 'Publicación actualizada correctamente.' }
        end
        format.json { render :show, status: :ok, location: @pet }
      else
        format.html { render :edit }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pets/1
  # DELETE /pets/1.json
  def destroy
    @pet.destroy
    respond_to do |format|
      format.html { redirect_to pets_url, notice: 'Publicación eliminada correctamente.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pet
      @pet = Pet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pet_params
      params.require(:pet).permit(:animal_type, :age, :sex, :name, :description, :lost_on, :lost_in, :user_id, :race_id)
    end
end
