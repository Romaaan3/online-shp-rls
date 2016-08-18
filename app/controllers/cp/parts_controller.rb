class Cp::PartsController < Cp::AdminController

  load_and_authorize_resource :find_by => :slug
  before_action :set_part, only: [:show, :edit, :update, :destroy]

  # GET /cp/parts
  # GET /cp/parts.json
  def index
    @parts2 = Part.all
    @q = Part.ransack(params[:q])
    @parts = @q.result(distinct: true).sort_by_id.paginate(:page => params[:page], :per_page => 30)
    respond_to do |format|
      format.html
      format.csv { send_data @parts2.to_csv }
    end
  end

  def blank
    @parts = Part.all
    respond_to do |format|
      format.csv { send_data @parts.get_blank }
    end
  end

  # GET /cp/parts/1
  # GET /cp/parts/1.json
  def show
  end

  # GET /cp/parts/new
  def new
    @part = Part.new
    @part.stores.each do |store|
      store.existences.build
    end
  end

  # GET /cp/parts/1/edit
  def edit
  end

  # POST /cp/parts
  # POST /cp/parts.json
  def create
    @part = Part.new(part_params)

    respond_to do |format|
      if @part.save
        if params[:files]
          params[:files].each { |image|
            @part.pictures.create(file: image)
          }
        end
        format.html { redirect_to cp_part_path(@part), notice: 'Запчасть создана.' }
        format.json { render :show, status: :created, location: @part }
      else
        format.html { render :new }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cp/parts/1
  # PATCH/PUT /cp/parts/1.json
  def update
    respond_to do |format|
      if params[:files]
        params[:files].each { |image|
          @part.pictures.create(file: image)
        }
      end

      if @part.update(part_params)
        format.html { redirect_to cp_part_path(@part), notice: 'Запчасть обновлена.' }
        format.json { render :show, status: :ok, location: @part }
      else
        format.html { render :edit }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cp/parts/1
  # DELETE /cp/parts/1.json
  def destroy
    @part.destroy
    respond_to do |format|
      format.html { redirect_to cp_parts_url, notice: 'Запчасть удалена.' }
      format.json { head :no_content }
    end
  end

    def import
    Part.import(params[:file])
    redirect_to cp_parts_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_part
      @part = Part.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def part_params
      params.require(:part).permit(:name, :description, :cost_1, :cost_2, :brand_id, :category_id,
        existences_attributes: [:q, :store_id])
    end
end
