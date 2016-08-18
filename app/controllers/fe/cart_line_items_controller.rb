class Fe::CartLineItemsController < ApplicationController
  include CurrentCart
  include GetRateOfExchange
  before_action :get_rate_of_exchange
  before_action :set_fe_cart_line_item, only: [:show, :edit, :update, :destroy, :increment, :decrement]
  before_action :set_cart, only: [:create, :increment, :decrement, :destroy]
  # GET /fe/cart_line_items
  # GET /fe/cart_line_items.json
  def index
    @fe_cart_line_items = CartLineItem.all
  end

  # GET /fe/cart_line_items/1
  # GET /fe/cart_line_items/1.json
  def show
  end

  # GET /fe/cart_line_items/new
  def new
    @fe_cart_line_item = CartLineItem.new
  end

  # GET /fe/cart_line_items/1/edit
  def edit
  end

  # POST /fe/cart_line_items
  # POST /fe/cart_line_items.json
  def create
    part = Part.friendly.find(params[:part_id])
    @fe_cart_line_item = @cart.add_part(part.id)

    respond_to do |format|
      if @fe_cart_line_item.save
        format.html { redirect_to :back }
        format.js {render}
        format.json { render action: 'show',
          status: :created, location: @line_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fe/cart_line_items/1
  # PATCH/PUT /fe/cart_line_items/1.json
  def update
    respond_to do |format|
      if @fe_cart_line_item.update(fe_cart_line_item_params)
        format.html { redirect_to @fe_cart_line_item, notice: 'Cart line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @fe_cart_line_item }
      else
        format.html { render :edit }
        format.json { render json: @fe_cart_line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fe/cart_line_items/1
  # DELETE /fe/cart_line_items/1.json
  def destroy
    @fe_cart_line_item.destroy
  end

  def decrement
    @fe_cart_line_item.decrement
    respond_to do |format|
      if @fe_cart_line_item.save
        format.html {redirect_to :back}
        format.js
      end
    end
  end

  def increment
    @fe_cart_line_item.increment
    respond_to do |format|
      if @fe_cart_line_item.save
        format.html {redirect_to :back}
        format.js
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fe_cart_line_item
      @fe_cart_line_item = CartLineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fe_cart_line_item_params
      params.require(:fe_cart_line_item).permit(:part_id, :cart_id, :q)
    end
end
