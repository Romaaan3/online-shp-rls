class Fe::CatalogController < ApplicationController
  before_action :set_cart
  before_action :get_rate_of_exchange, :set_catalog_bc
	layout "fe_general"

  def index
  	if params[:category]
  		category = Category.friendly.find(params[:category])
      brand = Brand.friendly.find(params[:brand])
      @parts = category.parts.where(brand_id: brand.id).paginate(:page => params[:page], :per_page => 12)
    end
    if params[:brand] and params[:category].blank?
      @parts = Brand.friendly.find(params[:brand]).parts.paginate(:page => params[:page], :per_page => 12)
    end
    unless params[:brand]
      @parts = Part.paginate(:page => params[:page], :per_page => 12)
    end
    @q = Part.ransack(params[:q])
    unless params[:q].blank?
      @parts = @q.result(distinct: true).sort_by_id.paginate(:page => params[:page], :per_page => 12)
    end

    if params[:brand]
  		brand = Brand.friendly.find(params[:brand])
      add_breadcrumb brand.name, fe_catalog_index_path(brand: params[:brand])
      @title = "Запчасти для #{brand.name} продажа с доставкой в Минске :: SWAP.com.by"
      @description = "#{brand.name} - #{brand.description} / SWAP.com.by /"
    end
    if params[:category]
      add_breadcrumb category.name, fe_catalog_index_path(brand: params[:brand], category: params[:category])
      @title = "#{category.name.mb_chars.capitalize.to_s} для #{brand.name} продажа с доставкой в Минске :: SWAP.com.by"
      @description = "#{category.name.mb_chars.capitalize.to_s} для #{brand.name} - #{category.description} / SWAP.com.by /"
    end
    unless params[:brand]
      @title = "Каталог запчастей для мобильных устройств и планшетов в Минске :: SWAP.com.by"
      @description = "В этом разделе представлены все запчасти для мобильных устройств и планшетов имеющиеся в продаже / SWAP.com.by /"
    end
  end



  def show
    @part = Part.friendly.find(params[:part])
    add_breadcrumb @part.brand.name, fe_catalog_index_path(brand: @part.brand)
    add_breadcrumb @part.category.name, fe_catalog_index_path(brand: @part.brand, category: @part.category)
    add_breadcrumb @part.name, fe_catalog_part_path(@part.brand, @part.category, @part)
    @title = "#{@part.name} (#{@part.brand.name}: #{@part.category.name}) :: SWAP.com.by"
    @description = "#{@part.name} - #{@part.description} / SWAP.com.by /"
  end

  private
  def set_catalog_bc
    add_breadcrumb "Каталог", fe_catalog_index_url

  end

end
