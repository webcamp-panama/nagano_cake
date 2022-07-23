class Admin::OrdersController < ApplicationController


  def show
    @orders = Order.all
    #@order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_order_path
    else
      render :show
    end
  end

  def confirm
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
  end

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_cost)
  end

end
