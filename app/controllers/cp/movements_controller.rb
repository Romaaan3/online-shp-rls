class Cp::MovementsController < Cp::AdminController
  load_and_authorize_resource
  helper 'cp/movements'

  before_action :set_movement, only: [:show, :edit, :update, :destroy, :complete]

  def index
    @movements = Movement.all
  end

  def show
    @parts  = Part.all
    @stores = Store.all
  end

  def new
    @movement = Movement.new
  end

  def edit
  end

  def create
    @movement = Movement.new(movement_params)

    if @movement.save
      redirect_to cp_movement_path @movement, notice: 'Перемещение создано.'
    else
      render :new
    end
  end

  def update
    if @movement.update(movement_params)
      redirect_to cp_movement_path @movement, notice: 'Перемещение обновлено.'
    else
      render :edit
    end
  end

  def destroy
    @movement.destroy
    redirect_to cp_movements_url, notice: 'Перемещение удалено.'
  end

  def complete
    if @movement.lineitems.any?
      if @movement.complete?
        cancel_movement(@movement) unless @movement.lineitems.blank?
        redirect_to cp_movement_url(@movement), notice: 'Перемещение отменено.'
      else
        complete_movement(@movement) unless @movement.lineitems.blank?
        redirect_to cp_movement_url(@movement), notice: 'Перемещение проведено.'
      end
    else
      redirect_to cp_movement_url(@movement), notice: 'Нельзя провести пустое перемещение'
    end
  end

  private
    def set_movement
      @movement = Movement.friendly.find(params[:id])
    end

    def movement_params
      params.require(:movement).permit(:from_store_id, :to_store_id, :description, :complete)
    end

    # TODO: перенести в хелпер
    def complete_movement(movement)
      movement.lineitems.each do |li|
        if @movement.from_store
          temp_existence_from     = Existence.where(part_id: li.part_id, store_id: movement.from_store_id).first
          temp_existence_from.q   -= li.q
          temp_existence_from.save
        end
        if @movement.to_store
          temp_existence_to     = Existence.where(part_id: li.part_id, store_id: movement.to_store_id).first
          temp_existence_to.q   += li.q
          temp_existence_to.save
        end
        movement.complete = true
        movement.save
      end
    end

    def cancel_movement(movement)
      movement.lineitems.each do |li|
        if @movement.from_store
          temp_existence_from     = Existence.where(part_id: li.part_id, store_id: movement.from_store_id).first
          temp_existence_from.q   += li.q
          temp_existence_from.save
        end
        if @movement.to_store
          temp_existence_to       = Existence.where(part_id: li.part_id, store_id: movement.to_store_id).first
          temp_existence_to.q     -= li.q
          temp_existence_to.save
        end
        movement.complete = false
        movement.save
      end
    end
end
