class Cp::OrdersController < Cp::AdminController
  load_and_authorize_resource
  def index
    @orders = Order.all
  end

  def show
    @order  = Order.find(params[:id])
    @q = Part.ransack(params[:q])
    @parts = @q.result(distinct: true).sort_by_id.paginate(:page => params[:page], :per_page => 30)
    @stores = Store.all
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to cp_order_path(@order), notice: "Заказ ##{@order.id} создан."
    else
      render :new, notice: "Что-то пошло не так."
    end
  end

  def update
  end

  def edit
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to cp_orders_url, notice: 'Заказ удален.'
  end


  def complete
    @order = Order.find(params[:id])
    if @order.complete?
      cancel_order(@order) unless @order.lineitems.blank?
      redirect_to cp_order_url(@order), notice: 'Заказ отменен.'
    else
      complete_order(@order) unless @order.lineitems.blank?
      unless @order.lineitems.blank?
        redirect_to cp_order_url(@order), notice: 'Заказ выполнен.'
      else
        redirect_to cp_order_url(@order), alert: 'Добавьте сначала товары.'
      end
    end
  end

  def pay_order
      order = Order.find(params[:id])
      if order.payd == true
        order.payd = false
      else
        order.payd = true
      end
      order.save
      redirect_to :back
  end



  private
    def order_params
      params.require(:order).permit(:client_id, :from_store_id).merge(seller_id: current_user.id)
    end

    # TODO: перенести в хелпер
    def complete_order(order)
      order.lineitems.each do |li|
        if @order.from_store
          temp_existence_from     = Existence.where(part_id: li.part_id, store_id: order.from_store_id).first
          temp_existence_from.q   -= li.q
          temp_existence_from.save
        end
        order.complete = true
        order.save
      end
    end

    def cancel_order(order)
      order.lineitems.each do |li|
        if @order.from_store
          temp_existence_from     = Existence.where(part_id: li.part_id, store_id: order.from_store_id).first
          temp_existence_from.q   += li.q
          temp_existence_from.save
        end
        order.complete = false
        order.save
      end
    end


end
