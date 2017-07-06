class AdoptionsController < ApplicationController
  before_filter :authenticate_user!, except: [:index,:show,:get_drop_down_options]
  load_and_authorize_resource

  # GET /adoptions
  # GET /adoptions.json
  def index
    @adoptions =Adoption.where(solved: false)
    @adoptions = @adoptions.animal_type(params[:animal_type]) if params[:animal_type].present?
    @adoptions = @adoptions.sex(params[:sex]) if params[:sex].present?
    @adoptions = @adoptions.race(params[:race]) if params[:race].present?
    @adoptions = @adoptions.date(params[:date]) if params[:date].present?
#    @adoptions = @adoptions.status(params[:status]) if params[:status].present?
    if params[:lost_in].present?
      coords=Geocoder.coordinates(params[:lost_in]) 
      @adoptions = @adoptions.near(coords,0.3)
    end
    @adoptions=@adoptions.paginate(:page => params[:page], :per_page => 10).order('created_at DESC') unless params[:sort].present?
    @adoptions=@adoptions.paginate(:page => params[:page], :per_page => 10).order('created_at DESC') if params[:sort]=="Recientes"
    @adoptions=@adoptions.paginate(:page => params[:page], :per_page => 10).order('created_at ASC') if params[:sort]=="Antiguos"
    @adoptions=@adoptions.paginate(:page => params[:page], :per_page => 10) if params[:sort]=="Cercanía"
    @adoptions=@adoptions.paginate(:page => params[:page], :per_page => 10).includes(:race).joins(:race).order('name ASC') if params[:sort]=="Raza"
    @adoptions=@adoptions.paginate(:page => params[:page], :per_page => 10).order('sex ASC') if params[:sort]=="Sexo"

  end

  # GET /adoptions/1
  # GET /adoptions/1.json
  def show
    @comment=Comment.new
  end

  # GET /adoptions/new
  def new
    @adoption = Adoption.new
  end

  # GET /adoptions/1/edit
  def edit
  end

  # POST /adoptions
  # POST /adoptions.json
  def create
    @adoption = Adoption.new(adoption_params)
    @adoption.user_id = current_user.id
    @adoption.solved= false
  
    respond_to do |format|
      if params[:images].present?
        if @adoption.save and params[:images].present?
          if params[:images]
            params[:images].each { |image|
            @adoption.images.create(image: image)
          }
          end
          format.html { redirect_to @adoption }
          format.json { render :show, status: :created, location: @adoption }
 #         coord=Geocoder.coordinates(params[:location]) 
 #         @users_near= User.near(coord,2)
 #         @users_near.each do |near|
 #             unless (near==@adoption.user)
 #               user=near
 #               title="Se ha perdido un animal cerca tuyo!"
 #               body= near.location
 #               url= animal_url(@adoption)
 #               Notification.create(user: user, titulo: title, mensaje: body, url: url, seen: 0)
 #             end
             Spawnling.new do
             if @adoption.lost_in
               coords=Geocoder.coordinates(@adoption.lost_in) 
               @users = User.near(coords,0.3)
                title="Una mascota cerca tuyo necesita adopción."
                body= @adoption.lost_in
                url= adoption_url(@adoption)
               if @adoption.images.first.image.url
                  pic_url=@adoption.images.first.image.url
                else
                  pic_url=image_path('logo.jpg')
                end               
               @users.each do |x|
                unless x==@adoption.user
                
                noti=Notification.create(user: x, titulo: title, mensaje: body, url: url, seen: 0, pic_url: pic_url, adoption: @adoption)
                notify(x,title,body,notification_url(noti))
              end
               end
             end  
             end  
          else
            unless params[:images].present?
              @adoption.errors.add(:images)
            end            
           format.html { render :new }
           format.json { render json: @adoption.errors, status: :unprocessable_entity }
          end
      else
        unless params[:images].present?
          @adoption.errors.add(:images)
        end
        format.html { render :new }
        format.json { render json: @adoption.errors, status: :unprocessable_entity }      
    end
    end
  end

  # PATCH/PUT /adoptions/1
  # PATCH/PUT /adoptions/1.json
  def update
   respond_to do |format|
      
      if @adoption.update(adoption_params)
        if params[:images]
          params[:images].each { |image|
          @adoption.images.create(image: image)
        }
        end
        if params[:selected]
          params[:selected].each { |selecte|
            @adoption.images.destroy(selecte)
          }
        end
        if adoption_params[:solved]
        format.html { redirect_to @adoption}
        else
        format.html { redirect_to @adoption, notice: 'Publicación actualizada correctamente.' }
        end
        format.json { render :show, status: :ok, location: @adoption }
      else
        format.html { render :edit }
        format.json { render json: @adoption.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adoptions/1
  # DELETE /adoptions/1.json
  def destroy
    @adoption.destroy
    respond_to do |format|
      format.html { redirect_to adoptions_url, notice: 'Adoption was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
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
    def set_adoption
      @adoption = Adoption.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def adoption_params
      params.require(:adoption).permit(:animal_type, :age,:sex, :name, :description, :lost_on, :lost_in, :user_id, :race_id, :solved)
    end
end
