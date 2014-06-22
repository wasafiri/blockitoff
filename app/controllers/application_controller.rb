class ApplicationController < ActionController::Base

  include Pundit
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' } #api

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_filter :authenticate_user_from_token! #api
  # before_filter :authenticate_user! #api - was making auth fail

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def authenticate_user_from_token! #api
    user_email = request.headers["X-API-EMAIL"].presence        #rather than send data over parameters, expect the
    user_auth_token = request.headers["X-API-TOKEN"].presence   #client application to send it via two headers:
    user = user_email && User.find_by_email(user_email)         #"X-API-EMAIL" and "X-API-TOKEN"; this cleans up the
                                                                #endpoint URLs

    # use Devise.secure_compare to compare token in db with token
    # given in params. do this to mitigate timing attacks.

    if user && Devise.secure_compare(user.authentication_token, user_auth_token)
      sign_in(user, store: false)
    end
  end
end
