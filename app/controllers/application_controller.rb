class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
before_filter :configure_permitted_parameters, if: :devise_controller?
before_action :store_current_location, :unless => :devise_controller?

# Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    "#{root_path}?logout=true"
  end



#  def after_sign_in_path_for(resource)
 #   "#{request.env['omniauth.origin']}?login=true" || "#{stored_location_for(resource)}?login=true" || "#{root_path}?login=true"
  #end



  def notify(user,title,body,url)
    
  	message = {
	  title: title,
	  body: body,
	  icon: "/icon-min.png",
	  url: url
	}
  	user.devices.each do |device|
      #TRY CATCH PARA WEBPUSH, MANEJO DE ERRORES
      begin
  	 Webpush.payload_send(
     	message: JSON.generate(message),
	 	endpoint: device.endpoint,
	 	p256dh: device.p256dh,
	 	auth: device.auth,
	 	ttl: 24 * 60 * 60,
	 	vapid: {
	 	subject: 'mailto:sender@example.com',
	 	public_key: Rails.application.secrets.VAPID_PUBLIC_KEY,
    private_key: Rails.application.secrets.VAPID_PRIVATE_KEY
   }
 )
     rescue
      device.destroy
  end
  	end
  
  end

  #def notify(user,notid)
  #  message= {
  #    icon: "/icon-min.png",
  #    url: "/notifications/#{notid}"
  #  }
#
  #  user.devices.each do |device|
  #    begin
  #      Webpush.payload_send(
  #        message: JSON.generate(message),
  #        endpoint: device.endpoint,
  #        p256dh: device.p256dh,
  #        auth: device.auth,
  #        ttl: 24 * 60 * 60,
  #        vapid: {
  #          subject: 'mailto:sender@example.com',
  #          public_key: Rails.application.secrets.VAPID_PUBLIC_KEY,
  #          private_key: Rails.application.secrets.VAPID_PRIVATE_KEY
  #        }
  #      )
  #    rescue
  #      device.destroy
  #    end
  #  end 
  #end
private
  # override the devise helper to store the current location so we can
  # redirect to it after loggin in or out. This override makes signing in
  # and signing up work automatically.
  def store_current_location
    store_location_for(:user, request.url) if request.get?
  end

protected
def configure_permitted_parameters
  #devise_parameter_sanitizer.for(:sign_up) << :name
  #devise_parameter_sanitizer.for(:account_update) << :name
  devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:avatar,:phone,:address])
  devise_parameter_sanitizer.permit(:account_update, keys: [:name,:avatar,:phone,:address])
end
end
