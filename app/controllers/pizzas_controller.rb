class PizzasController < ApplicationController
  def index
    pizzas = Pizza.all
    render json: pizzas, status: :ok
  end

  def show
    pizza = Pizza.find(params[:id])
    render json: pizza, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Pizza not found" }, status: :not_found
  end

  def create
    pizza = Pizza.new(pizza_params)
    if pizza.save
      render json: pizza, status: :created
    else
      render json: { errors: pizza.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    pizza = Pizza.find(params[:id])
    if pizza.update(pizza_params)
      render json: pizza, status: :ok
    else
      render json: { errors: pizza.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    pizza = Pizza.find(params[:id])
    pizza.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Pizza not found" }, status: :not_found
  end

  private

  def pizza_params
    params.require(:pizza).permit(:name, :category, :price, :quantity)
  end
end