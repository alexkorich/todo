class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  respond_to :html, :json
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_filter :set_csrf_cookie_for_ng
  
  def angular
    render 'layouts/application'
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end
  
  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

 rescue_from CanCan::AccessDenied do |exception|
    render json: {error: exception.message}, status: :forbidden
  end
  rescue_from ActionController::ParameterMissing do |exception|
    render json: {error: exception.message}, status: 422
  end
  
end
