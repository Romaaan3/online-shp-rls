class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	http_basic_authenticate_with name: "swap", password: "password123"
  	protect_from_forgery with: :exception
	include LocalSubdomain
	include CurrentCart
	include GetRateOfExchange
	layout :layout_by_resource

	before_filter :set_catalog_menu, :set_main_page_bc, :set_cart, :get_rate_of_exchange


	def after_sign_in_path_for(resource)
		if current_user.role != Role.find_by_name(:client)
		  cp_root_url
		else
			fe_root_url
		end
	end
  def after_sign_out_path_for(resource_or_scope)
		fe_root_url
  end

  def set_catalog_menu
    @brands = Brand.all
    @categories = Category.all
    @last_news = News.limit(4)
  end

	protected

	  def layout_by_resource
	    if devise_controller?
	      "auth"
	    else
	      "fe_general"
	    end
	  end

  def set_main_page_bc
    add_breadcrumb "Главная", fe_root_url
  end
end
