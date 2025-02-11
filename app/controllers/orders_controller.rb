class OrdersController < ApplicationController
  def create
    order = Order.new(status: "pending")
    params[:order_items].each do |item_params|
      pizza = Pizza.find(item_params[:pizza_id])
      crust = Crust.find(item_params[:crust_id])
      side = Side.find_by(id: item_params[:side_id])

      order.order_items.build(pizza: pizza, crust: crust, side: side)
    end

    if order.save
      order.calculate_total
      render json: { message: "Order placed successfully", order: order }, status: :created
    else
      render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    order = Order.find(params[:id])
    render json: order, include: :order_items
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Order not found" }, status: :not_found
  end

  private

  def order_params
    params.require(:order).permit(order_items: [:pizza_id, :crust_id, :side_id])
  end
end