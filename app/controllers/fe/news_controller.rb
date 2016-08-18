class Fe::NewsController < ApplicationController
  before_filter :set_bc
  def index
  	@news = News.all.paginate(:page => params[:page], :per_page => 10)
    @title = "Новости :: SWAP.com.by"
    @description = "Раздел новостей на сайте SWAP.com.by"
  end

  def show
  	@one = News.friendly.find(params[:id])
    add_breadcrumb @one.name, fe_news_url(@one)
    @title = "#{@one.name} :: SWAP.com.by"
    @title = "#{@one.anons} / SWAP.com.by /"
  end

  private
	  def set_bc
	    add_breadcrumb "Новости", fe_news_index_url
	  end
end
