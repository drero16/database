class RisksController < ApplicationController
  before_filter :authenticate_user!, except: [:index,:show,:get_drop_down_options]
  #before_action :set_risk, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /risks
  # GET /risks.json
  def index
    #@risks = Risk.where(risk_state: 1)
    @risks = Risk.where(solved: false)
    @risks = @risks.animal_type(params[:animal_type]) if params[:animal_type].present?
    @risks = @risks.sex(params[:sex]) if params[:sex].present?
    @risks = @risks.race(params[:race]) if params[:race].present?
    @risks = @risks.date(params[:date]) if params[:date].present?
#    @risks = @risks.status(params[:status]) if params[:status].present?
    if params[:location].present?
      coords=Geocoder.coordinates(params[:location]) 
      @risks = @risks.near(coords,0.3)
    end
    @risks=@risks.paginate(:page => params[:page], :per_page => 10).order('created_at DESC') unless params[:sort].present?
    @risks=@risks.paginate(:page => params[:page], :per_page => 10).order('created_at DESC') if params[:sort]=="Recientes"
    @risks=@risks.paginate(:page => params[:page], :per_page => 10).order('created_at ASC') if params[:sort]=="Antiguos"
    @risks=@risks.paginate(:page => params[:page], :per_page => 10) if params[:sort]=="Cercanía"
    @risks=@risks.paginate(:page => params[:page], :per_page => 10).includes(:race).joins(:race).order('name ASC') if params[:sort]=="Raza"
    @risks=@risks.paginate(:page => params[:page], :per_page => 10).order('sex ASC') if params[:sort]=="Sexo"
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
    @risk.solved= false
  
    respond_to do |format|
      if params[:images].present?
        if @risk.save and params[:images].present?
          if params[:images]
            params[:images].each { |image|
            @risk.images.create(image: image)
          }
          end
          format.html { redirect_to @risk }
          format.json { render :show, status: :created, location: @risk }
 #         coord=Geocoder.coordinates(params[:location]) 
 #         @users_near= User.near(coord,2)
 #         @users_near.each do |near|
 #             unless (near==@risk.user)
 #               user=near
 #               title="Se ha perdido un risk cerca tuyo!"
 #               body= near.location
 #               url= risk_url(@risk)
 #               Notification.create(user: user, titulo: title, mensaje: body, url: url, seen: 0)
 #             end
             Spawnling.new do
             if @risk.location
               coords=Geocoder.coordinates(@risk.location) 
               @users = User.near(coords,0.3)
               @users.each do |x|
                unless x==@risk.user
                title="Un animal cerca tuyo está en riesgo."
                body= @risk.location
                url= risk_url(@risk)
               if @risk.images.first.image.url
                  pic_url=@risk.images.first.image.url
                else
                  pic_url=image_path('logo.jpg')
                end                
                noti=Notification.create(user: x, titulo: title, mensaje: body, url: url, seen: 0, pic_url: pic_url, risk: @risk)
                notify(x,title,body,notification_url(noti))
              end
               end
             end  
             end  
          else
            unless params[:images].present?
              @risk.errors.add(:images)
            end            
           format.html { render :new }
           format.json { render json: @risk.errors, status: :unprocessable_entity }
          end
      else
        unless params[:images].present?
          @risk.errors.add(:images)
        end
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
        if params[:selected]
          params[:selected].each { |selecte|
            @risk.images.destroy(selecte)
          }
        end
        if risk_params[:solved]
        format.html { redirect_to @risk}
        else
        format.html { redirect_to @risk, notice: 'Publicación actualizada correctamente.' }
        end
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
      format.html { redirect_to risks_url, notice: 'Publicación eliminada correctamente.' }
      format.json { head :no_content }
      format.js
    end
  end

  def solved
    @risk=@risk.solved(risk_params[solved])
  end

    def get_drop_down_options
    val = params[:animal_type]
    #Use val to find records
    @races= Race.where(description: val)
    options = @races.collect{|x| "'#{x.id}' : '#{x.name}'"}    
    render :text => "{#{options.join(",")}}" 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_risk
      @risk = Risk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def risk_params
      params.require(:risk).permit(:animal_type, :age, :sex, :location, :description, :user_id, :race_id, :solved)
    end
    def filtering_params
      params.slice(:animal_type, :sex, :location)
    end
end
