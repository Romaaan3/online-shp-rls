class Cp::AdminController < ApplicationController
	before_action :authenticate_user!
  include CanCan::ControllerAdditions
  layout "cp"

  rescue_from CanCan::AccessDenied do |exception|
    if current_user.client?
      redirect_to fe_catalog_index_url
    else
      redirect_to cp_root_path, :alert => exception.message
    end
  end
end
