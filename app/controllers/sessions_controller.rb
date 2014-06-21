# override Devise's sessions controller with our own

class SessionsController < Devise::SessionsController
  skip_before_filter :authenticate_user!, :only => [:create, :new]
  skip_before_filter :verify_authenticity_token
  # skip_authorization_check only: [:create, :failure, :show_current_user, :options, :new]
  respond_to :json, :html

  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

  # return the user's email and authentication token. These are all that are required for subsequent API requests
  # until we either reset the token (typically via TTL) or the user resets the token via #destroy
  def create
    respond_to do |format|
      format.json {

        resource = resource_from_credentials
        #build_resource
        return invalid_login_attempt unless resource

        if resource.valid_password?(params[:password])
          render :json => JSON.pretty_generate({ user: { email: resource.email, :auth_token => resource.authentication_token } }), success: true, status: :created
        else
          invalid_login_attempt
        end
      }
    end
  end

  # authenticate via the 'X-API-TOKEN' header sent by the client, and reset the users' authentication token
  def destroy
    respond_to do |format|
      format.html {
        super
      }
      format.json {
        user = User.find_by_authentication_token(request.headers['X-API-TOKEN'])
        if user
          user.reset_authentication_token!
          render :json => { :message => 'Session deleted.' }, :success => true, :status => 204
        else
          render :json => { :message => 'Invalid token.' }, :status => 404
        end
      }
    end
  end

  protected
  def invalid_login_attempt
    warden.custom_failure!
    render json: { success: false, message: 'Error with your login or password' }, status: 401
  end

  def resource_from_credentials
    data = { email: params[:email] }
    if res = resource_class.find_for_database_authentication(data)
      if res.valid_password?(params[:password])
        res
      end
    end
  end
end