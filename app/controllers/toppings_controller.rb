class ToppingsController < ApplicationController
  def index
    toppings = Topping.all
    render json: toppings, status: :ok
  end

  def show
    topping = Topping.find(params[:id])
    render json: topping, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Topping not found" }, status: :not_found
  end

  def create
    topping = Topping.new(topping_params)
    if topping.save
      render json: topping, status: :created
    else
      render json: { errors: topping.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    topping = Topping.find(params[:id])
    if topping.update(topping_params)
      render json: topping, status: :ok
    else
      render json: { errors: topping.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    topping = Topping.find(params[:id])
    topping.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Topping not found" }, status: :not_found
  end

  private

  def topping_params
    params.require(:topping).permit(:name, :topping_type, :price, :quantity)
  end
end