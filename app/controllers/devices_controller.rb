class DevicesController < ApplicationController

  before_action :set_device, only: [:show, :edit, :update, :destroy]

  # GET /devices
  # GET /devices.json
  def index
#    @devices = Device.all
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
  end

  # GET /devices/new
  def new
#    @device = Device.new
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  # POST /devices.json
  def create
    unless current_user
      render json: current_user, status: :ok and return
    end    
    existing_device=Device.find_by(endpoint: params[:subscription][:endpoint])
    if existing_device
      #endpoint= params[:subscription][:endpoint]
      #p256dh= params[:subscription][:keys][:p256dh]
      #auth= params[:subscription][:keys][:auth]
      #existing_device.update(endpoint: endpoint,p256dh: p256dh, auth: auth)
      #render json: existing_device, status: :ok and return
      existing_device.destroy
    end
    @device = Device.new()
    @device.user_id=current_user.id

    @device.endpoint= params[:subscription][:endpoint]
    @device.p256dh= params[:subscription][:keys][:p256dh]
    @device.auth= params[:subscription][:keys][:auth]
#    @device.save
  respond_to do |format|
     if @device.save
#       format.html { redirect_to @device, notice: 'Device was successfully created.' }
       format.json { render :json => {:message=>"Sucess"}}
#        @message = {
#  title: "Llamado para",
#  body: "ELba Neado",
#  icon: "/icon-min.png",
#  url: "/events/"
#}
#        Webpush.payload_send(
#          message: JSON.generate(@message),
#    endpoint: @device.endpoint,
#    p256dh: @device.p256dh,
#    auth: @device.auth,
#    ttl: 24 * 60 * 60,
#    vapid: {
#      subject: 'mailto:sender@example.com',
#      public_key: ENV['VAPID_PUBLIC_KEY'],
#      private_key: ENV['VAPID_PRIVATE_KEY']
#    }
#  )
#     
#     else
#       format.html { render :new }
#       format.json { render json: @device.errors, status: :unprocessable_entity }
     end
   end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
 #   respond_to do |format|
 #     if @device.update(device_params)
 #       format.html { redirect_to @device, notice: 'Device was successfully updated.' }
 #       format.json { render :show, status: :ok, location: @device }
 #     else
 #       format.html { render :edit }
 #       format.json { render json: @device.errors, status: :unprocessable_entity }
 #     end
 #   end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
#   @device.destroy
#   respond_to do |format|
#     format.html { redirect_to devices_url, notice: 'Device was successfully destroyed.' }
#     format.json { head :no_content }
#   end
# end

# private
#   # Use callbacks to share common setup or constraints between actions.
#   def set_device
#     @device = Device.find(params[:id])
#   end

#   # Never trust parameters from the scary internet, only allow the white list through.
#   def device_params
#     params.require(:device).permit(:user_agent, :endpoint, :p256dh, :auth, :user_id)
   end

   def unsubscribe
#    unless current_user
#      
#    end    
#    @existing_device=current_user.devices.find_by(endpoint: params[:subscription][:endpoint])
#    if @existing_device
#      @existing_device.destroy
#    end

    @existing_device=Device.find_by(endpoint: params[:subscription][:endpoint])
    if @existing_device
      @existing_device.destroy
    end
    render json: current_user, status: :ok and return
   end

end
