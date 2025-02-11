class OrdersController < ApplicationController
  def create
    result = OrderHandler.new(current_user, order_params).create_order

    if result[:success]
      render json: { message: result[:message], order: result[:order] }, status: :created
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
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
