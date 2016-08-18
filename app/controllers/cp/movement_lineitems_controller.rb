class Cp::MovementLineitemsController < Cp::AdminController
  load_and_authorize_resource
  before_action :set_movement_lineitem, only: [:update, :destroy]

  def create
    @movement_lineitem = MovementLineitem.new(movement_lineitem_params)
    if @movement_lineitem.save
      @lineitems = @movement_lineitem.movement.lineitems
    end
  end

  def update
    @movement_lineitem.update(movement_lineitem_params)
  end

  def destroy
    @movement_lineitem.destroy
  end

  private
    def set_movement_lineitem
      @movement_lineitem = MovementLineitem.find(params[:id])
      @lineitems = @movement_lineitem.movement.lineitems
    end

    def movement_lineitem_params
      params.require(:movement_lineitem).permit(:part_id, :movement_id, :q)
    end
end
