class Cp::CategoriesController < Cp::AdminController
  load_and_authorize_resource :find_by => :slug
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /cp/categories
  # GET /cp/categories.json
  def index
    @categories = Category.all
    respond_to do |format|
      format.html
      format.csv { send_data @categories.to_csv }
    end
  end

  def blank
    @categories = Category.all
    respond_to do |format|
      format.csv { send_data @categories.get_blank }
    end
  end
  # GET /cp/categories/1
  # GET /cp/categories/1.json
  def show
  end

  # GET /cp/categories/new
  def new
    @category = Category.new
  end

  # GET /cp/categories/1/edit
  def edit
  end

  # POST /cp/categories
  # POST /cp/categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to cp_category_url(@category), notice: 'Катеогория запчастей создана.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cp/categories/1
  # PATCH/PUT /cp/categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to cp_category_url(@category), notice: 'Катеогория запчастей обновлена.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cp/categories/1
  # DELETE /cp/categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to cp_categories_url, notice: 'Катеогория запчастей удалена.' }
      format.json { head :no_content }
    end
  end
      def import

      Category.import(params[:file])
      redirect_to cp_categories_url
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :description)
    end


end
