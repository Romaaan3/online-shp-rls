class Fe::StaticPagesController < ApplicationController
  before_filter :set_catalog_menu
  include ApplicationHelper
	
  layout "fe_homepage"
	layout_by_action [:home] => "fe_homepage", [:dostavka_i_oplata, :kontakty] => "fe_general"
  def home
  	# @email = Email.new
    @block_1 = Block.find_by_name("Главная страница")
    @novost = News.last
    if params[:q].blank?
     @q = Part.none.search
    else
      @q = Part.ransack(params[:q])
    end
    @parts = @q.result(distinct: true).sort_by_id.paginate(:page => params[:page], :per_page => 10)
  end

  def dostavka_i_oplata
  	@block_1 = Block.find_by_name("Доставка и оплата")
    add_breadcrumb "Доставка и оплата", fe_dip_url
  end

  def kontakty
    @block_1 = Block.find_by_name("Контакты")
    add_breadcrumb "Контакты", fe_kontakty_url
  end
end
