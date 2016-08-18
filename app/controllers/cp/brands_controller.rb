class Cp::BrandsController < Cp::AdminController
  load_and_authorize_resource :find_by => :slug
  before_action :set_brand, only: [:show, :edit, :update, :destroy]

  # GET /cp/brands
  # GET /cp/brands.json
  def index
    @brands = Brand.all
    respond_to do |format|
      format.html
      format.csv { send_data @brands.to_csv }
    end
  end

  def blank
    @brands = Brand.all
    respond_to do |format|
      format.csv { send_data @brands.get_blank }
    end
  end

  # GET /cp/brands/1
  # GET /cp/brands/1.json
  def show

  end

  # GET /cp/brands/new
  def new
    @brand = Brand.new
  end

  # GET /cp/brands/1/edit
  def edit
  end

  # POST /cp/brands
  # POST /cp/brands.json
  def create
    @brand = Brand.new(brand_params)

    respond_to do |format|
      if @brand.save
        format.html { redirect_to cp_brand_url(@brand), notice: 'Бренд создан.' }
        format.json { render :show, status: :created, location: @brand }
      else
        format.html { render :new }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cp/brands/1
  # PATCH/PUT /cp/brands/1.json
  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to cp_brand_url(@brand), notice: 'Бренд обновлен.' }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :edit }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cp/brands/1
  # DELETE /cp/brands/1.json
  def destroy
    @brand.destroy
    respond_to do |format|
      format.html { redirect_to cp_brands_url, notice: 'Бренд удален.' }
      format.json { head :no_content }
    end
  end
  def import
    Brand.import(params[:file])
    redirect_to cp_brands_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brand.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brand_params
      params.require(:brand).permit(:name, :description)
    end
end
