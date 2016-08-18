class Cp::OrderLineitemsController < Cp::AdminController
  
  load_and_authorize_resource
  before_action :set_order_lineitem, only: [:update, :destroy]

  def create
    @order_lineitem = OrderLineitem.new(order_lineitem_params)
    if @order_lineitem.save
      @order = @order_lineitem.order
      @order_lineitem.p_name = @order_lineitem.part.name
      @order_lineitem.p_cost = @order_lineitem.part.cost_1
      @order_lineitem.p_full_cost = @order_lineitem.p_cost * @order_lineitem.q
      @order_lineitem.save
      @lineitems = @order_lineitem.order.lineitems
      order_update_full_cost(@order_lineitem.order)
    end
  end

  def update
    @order_lineitem.update(order_lineitem_params)
    unless @order_lineitem.errors.any?
      @order_lineitem.p_full_cost = @order_lineitem.p_cost * @order_lineitem.q
      @order_lineitem.save
      order_update_full_cost(@order_lineitem.order)
    end
  end

  def destroy
    @order_lineitem.destroy
    order_update_full_cost(@order_lineitem.order)
  end

  private
    def set_order_lineitem
      @order_lineitem = OrderLineitem.find(params[:id])
    end

    def order_lineitem_params
      params.require(:order_lineitem).permit(:q, :part_id, :order_id)
    end

    def order_update_full_cost(order)
      order.full_cost = 0
      order.lineitems.each do |lineitem|
        order.full_cost += lineitem.p_full_cost
      end
      order.save
    end
end
