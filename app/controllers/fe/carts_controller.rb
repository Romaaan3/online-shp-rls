class Fe::CartsController < ApplicationController
  include CurrentCart
  include GetRateOfExchange
  before_action :get_rate_of_exchange
  before_action :set_cart, only: [:show, :edit, :update, :destroy, :checkout, :payment, :payment_success, :payment_error]
  before_action :set_payd, only: [:payment_success]
  def show
    add_breadcrumb "Товары в корзине", fe_current_cart_path
    @title = "Корзина товаров :: SWAP.com.by"

  end

  def checkout
    if @cart.cart_line_items.empty?
      redirect_to fe_current_cart_url, notice: "Корзина пуста..."
    end
    add_breadcrumb "Товары в корзине", fe_current_cart_path
    add_breadcrumb "Оформление покупки", fe_cart_checkout_path
    @order = Order.new

    @title = "Оформление заказа :: SWAP.com.by"
  end



  def payment
    if session[:order_id]
      @order = Order.find(session[:order_id])

    else
      redirect_to fe_catalog_index_url
    end
  end

  def payment_success

  end

  def payment_error
  end

  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_payd
    if session[:order_id]
      @order = Order.find(session[:order_id])
      @order.payd = 1
      @order.save
    else
      redirect_to fe_catalog_index_url
    end
  end

  private
    def cart_params
      params.fetch(:cart, {})
    end
end
