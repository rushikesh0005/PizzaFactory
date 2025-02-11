class OrderHandler
  def initialize(user, order_params)
    @user = user
    @order_params = order_params
  end

  def create_order
    order = @user.orders.new(status: "confirmed")

    @order_params[:order_items].each do |item_params|
      order_item = build_order_item(order, item_params)
      return failure_response(order_item.errors.full_messages) unless order_item.valid?
    end

    return failure_response(order.errors.full_messages) unless order.save

    process_order(order)
    success_response(order)
  end

  private

  def build_order_item(order, item_params)
    pizza = Pizza.find(item_params[:pizza_id])
    crust = Crust.find(item_params[:crust_id])
    side = Side.find_by(id: item_params[:side_id])

    order_item = order.order_items.build(pizza: pizza, crust: crust, side: side)
    add_toppings(order_item, item_params[:toppings]) if item_params[:toppings].present?
    order_item
  end

  def add_toppings(order_item, toppings_params)
    toppings_params.each do |topping_params|
      topping = Topping.find(topping_params[:id])
      order_item.toppings << topping
    end
  end

  def process_order(order)
    order.order_items.each(&:reduce_inventory)
    order.calculate_total
  end

  def success_response(order)
    { success: true, message: "Order placed successfully", order: order }
  end

  def failure_response(errors)
    { success: false, errors: errors }
  end
end
