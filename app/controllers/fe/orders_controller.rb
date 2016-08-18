class Fe::OrdersController < ApplicationController
  include CurrentCart
  include GetRateOfExchange
  before_action :get_rate_of_exchange

  before_action :set_cart
  def create
    full_cost = 0
    @order = Order.new(order_params)
    if @order.save
      @cart.cart_line_items.each do |l|
        order_line_item = OrderLineitem.new
          order_line_item.order_id = @order.id
          order_line_item.q = l.q
          order_line_item.part_id = l.part_id
          order_line_item.p_cost = l.part.cost_1
          order_line_item.p_full_cost = l.part.cost_1 * l.q
          order_line_item.p_name = l.part.name
        order_line_item.save
        full_cost += (l.part.cost_1 * l.q)
      end
      @order.full_cost = full_cost


      rand_password=('a'..'z').to_a.shuffle.first(8).join
      @user = User.new(:email => @order.email, :password => rand_password)
      if @user.save
        UserMailer.confirm_email(@order, rand_password, @user, @rate.rate_of_exchange).deliver_now
        @order.client_id = @user.id
      else
        UserMailer.successful_order(@order, @rate.rate_of_exchange).deliver_now
        if current_user
          @order.client_id = current_user
        end
      end

      if @order.save
        @cart.destroy
        session[:order_id] = @order.id
        redirect_to  fe_cart_payment_url
      end
    else
      render "fe/carts/checkout"
    end
  end

  private

  def order_params
    params.require(:order).permit(:tip_dostavki, :familija, :name, :otchestvo, :mobile,
     :email, :gorod, :ulica, :dom, :korpus, :kv, :postal_index, :tip_oplaty, :comment)
    .merge(seller_id: User.find_by_email("shop@swap.com.by").id, from_store_id: Store.find_by_name("Интернет-магазин").id)
  end
end
