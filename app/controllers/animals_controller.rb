class AnimalsController < ApplicationController
  before_filter :authenticate_user!, except: [:index,:show,:get_drop_down_options]
  #before_action :set_animal, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /animals
  # GET /animals.json
  def index
    #@animals = Animal.where(animal_state: 0)
#    @filters= Animal.new(animal_params)
    #@animals = Animal.where(animal_state: 0)
    @animals =Animal.where(solved: false)
    @animals = @animals.animal_type(params[:animal_type]) if params[:animal_type].present?
    @animals = @animals.sex(params[:sex]) if params[:sex].present?
    @animals = @animals.race(params[:race]) if params[:race].present?
    @animals = @animals.date(params[:date]) if params[:date].present?
#    @animals = @animals.status(params[:status]) if params[:status].present?
    if params[:location].present?
      coords=Geocoder.coordinates(params[:location]) 
      @animals = @animals.near(coords,0.3)
    end

    @animals=@animals.paginate(:page => params[:page], :per_page => 10).order('created_at DESC') if params[:sort]=="Recientes"
    @animals=@animals.paginate(:page => params[:page], :per_page => 10).order('created_at ASC') if params[:sort]=="Antiguos"
    @animals=@animals.paginate(:page => params[:page], :per_page => 10) if params[:sort]=="Cercanía"
    @animals=@animals.paginate(:page => params[:page], :per_page => 10).includes(:race).joins(:race).order('name ASC') if params[:sort]=="Raza"
    @animals=@animals.paginate(:page => params[:page], :per_page => 10).order('sex ASC') if params[:sort]=="Sexo"
    #@animals= @animals.paginate(page: params[:page], per_page: 5)
#    filtering_params(params).each do |key, value|
#      @animals=@animals.public_send(key,value) if value.present?
#    end
    
    
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
    @animal.solved= false
  
    respond_to do |format|
      if params[:images].present?
        if @animal.save and params[:images].present?
          if params[:images]
            params[:images].each { |image|
            @animal.images.create(image: image)
          }
          end
          format.html { redirect_to @animal }
          format.json { render :show, status: :created, location: @animal }
 #         coord=Geocoder.coordinates(params[:location]) 
 #         @users_near= User.near(coord,2)
 #         @users_near.each do |near|
 #             unless (near==@animal.user)
 #               user=near
 #               title="Se ha perdido un animal cerca tuyo!"
 #               body= near.location
 #               url= animal_url(@animal)
 #               Notification.create(user: user, titulo: title, mensaje: body, url: url, seen: 0)
 #             end
            Spawnling.new do
             if @animal.location
               coords=Geocoder.coordinates(@animal.location) 
               @users = User.near(coords,0.3)
               @users.each do |x|
                unless x==@animal.user
                title="Se ha encontrado un animal cerca tuyo!"
                body= @animal.location
                url= animal_url(@animal)
               if @animal.images.first.image.url
                  pic_url=@animal.images.first.image.url
                else
                  pic_url=image_path('logo.jpg')
                end                
                noti=Notification.create(user: x, titulo: title, mensaje: body, url: url, seen: 0, pic_url: pic_url, animal: @animal)
                notify(x,title,body,notification_url(noti))
              end
               end
             end  
             end        
          else
            unless params[:images].present?
              @animal.errors.add(:images)
            end            
           format.html { render :new }
           format.json { render json: @animal.errors, status: :unprocessable_entity }
          end
      else
        unless params[:images].present?
          @animal.errors.add(:images)
        end
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
        if params[:selected]
          params[:selected].each { |selecte|
            @animal.images.destroy(selecte)
          }
        end
        if animal_params[:solved]
        format.html { redirect_to @animal}
        else
        format.html { redirect_to @animal, notice: 'Publicación actualizada correctamente.' }
        end
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
      format.html { redirect_to animals_url, notice: 'Publicación eliminada correctamente.' }
      format.json { head :no_content }
      format.js
    end
  end

  def solved
    @animal=@animal.solved(animal_params[solved])
  end

  def get_drop_down_options
    val = params[:animal_type]
    #Use val to find records
    @races= Race.where(description: val)
    options = @races.collect{|x| "'#{x.id}' : '#{x.name}'"}    
    render :text => "{#{options.join(",")}}" 
  # respond_to do |format|
  #   format.json { render :json => options}
  # end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def animal_params
      params.require(:animal).permit(:animal_type, :age, :sex, :location, :description, :user_id, :race_id, :solved)
    end

    def filtering_params
      params.slice(:animal_type, :sex, :location)
    end

end
