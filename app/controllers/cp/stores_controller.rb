class Cp::StoresController < Cp::AdminController
  load_and_authorize_resource
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  # GET /cp/stores
  # GET /cp/stores.json
  def index
    @stores = Store.all
  end

  # GET /cp/stores/1
  # GET /cp/stores/1.json
  def show
  end

  # GET /cp/stores/new
  def new
    @store = Store.new
  end

  # GET /cp/stores/1/edit
  def edit
  end

  # POST /cp/stores
  # POST /cp/stores.json
  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to cp_store_url(@store), notice: 'Склад создан.' }
        format.json { render :show, status: :created, location: cp_store_url(@store) }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cp/stores/1
  # PATCH/PUT /cp/stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to cp_store_url(@store), notice: 'Склад обновлен.' }
        format.json { render :show, status: :ok, location: cp_store_url(@store) }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cp/stores/1
  # DELETE /cp/stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to cp_stores_url, notice: 'Склад удален.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:name)
    end
end
