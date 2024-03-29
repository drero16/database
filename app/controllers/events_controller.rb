class EventsController < ApplicationController
  #before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index,:show]
  load_and_authorize_resource

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @events= @events.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
  end

  # GET /events/1
  # GET /events/1.json
  def show
    
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create

    @event = Event.new(event_params)
    @event.user_id = current_user.id
    respond_to do |format|
      if params[:images].present?
        if @event.save and params[:images].present?
          if params[:images]
            params[:images].each { |image|
            @event.images.create(image: image)
          }
          end
                     Spawnling.new do
                      title=@event.user.name << " ha creado un evento!."
                  body=@event.title
                  url= event_url(@event)
                if @event.images.first.image.url
                  pic_url=@event.images.first.image.url
                else
                  pic_url=image_path('logo.jpg')
                end                      
              User.all.each do |x|

                unless (@event.user==x)
                noti=Notification.create(user: x, titulo: title, mensaje: body, url: url, seen: 0, pic_url: pic_url, event: @event)
                notify(x,title,body,notification_url(noti))
                    
                  
                end
              end
            end  
          format.html { redirect_to @event}
          format.json { render :show, status: :created, location: @event }
        
        else
          unless params[:images].present?
            @event.errors.add(:images)
          end
          format.html { render :new }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      else
        unless params[:images].present?
          @event.errors.add(:images)
        end
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }        
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        if params[:images]
          params[:images].each { |image|
          @event.images.create(image: image)
        }
        end
        if params[:selected]
          params[:selected].each { |selecte|
            @event.images.destroy(selecte)
          }
        end        
        format.html { redirect_to @event, notice: 'Evento actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Evento eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :date_event, :location, :user_id)
    end
end
