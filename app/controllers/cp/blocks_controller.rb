class Cp::BlocksController < Cp::AdminController
  before_action :set_block, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @blocks = Block.all
  end

  def show
  end

  def new
    @block = Block.new
  end

  def edit
  end

  def create
    @block = Block.new(block_params)

    respond_to do |format|
      if @block.save
        format.html { redirect_to cp_blocks_path, notice: 'Блок создан.' }
        format.json { render :show, status: :created, location: @block }
      else
        format.html { render :new }
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @block.update(block_params)
        format.html { redirect_to cp_blocks_path, notice: 'Блок обновлен.' }
        format.json { render :show, status: :ok, location: @block }
      else
        format.html { render :edit }
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @block.destroy
    respond_to do |format|
      format.html { redirect_to cp_blocks_url, notice: 'Блок удален.' }
      format.json { head :no_content }
    end
  end

  private
    def set_block
      @block = Block.find(params[:id])
    end

    def block_params
      params.require(:block).permit(:name, :text, :title, :description, :keywords)
    end
end
