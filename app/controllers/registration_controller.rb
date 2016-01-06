class RegistrationsController < Devise::RegistrationsController

  respond_to :json
  clear_respond_to
end