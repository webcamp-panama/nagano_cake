class Admin::OrdersController < ApplicationController
#before_action :authenticate_admin!

  # def show
  #   @order_details = OrderDetail.find(params[:id])
  #   @order = Order.find(params[:id])
  #   @orders = Order.all
  #   @customer = Customer.find(params[:id])
  #   #@order = Order.find(params[:id])
  # end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
    @total = @order.total_payment - @order.shipping_cost
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      if @order.status == "payment_confirm"
         @order.order_details.each do |order_detail|
         order_detail.update(making_status: "makig_waiting" )
         end
      end
      redirect_to admin_order_path
    else
      render :show
    end
  end

  # # def confirm
  ##    @order = Order.new(order_params)
  # #   @address = Address.find(params[:order][:address_id])
  # #   @order.postal_code = @address.postal_code
  ##    @order.address = @address.address
  # #   @order.name = @address.name
  # # end

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_cost, :created_at, :status, :making_status, :order_id)
  end

  def set_order
    @order = Order.find(params[:id])
  end

end
