class OrdersController < ApplicationController
  def create
    order = current_user.orders.new(status: "pending")
    puts order_params
    order_params[:order_items].each do |item_params|
      pizza = Pizza.find(item_params[:pizza_id])
      crust = Crust.find(item_params[:crust_id])
      side = Side.find_by(id: item_params[:side_id])

      order_item = order.order_items.build(pizza: pizza, crust: crust, side: side)

      unless order_item.valid?
        render json: { errors: order_item.errors.full_messages }, status: :unprocessable_entity
        return
      end
    end

    if order.save
      order.order_items.each(&:reduce_inventory)
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
    params.require(:order).permit(order_items: [:pizza_id, :crust_id, :side_id, toppings: [:id, :quantity]])
  end
end