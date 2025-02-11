class InventoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_vendor, only: [:update] 
  def index
    render json: Inventory.all
  end

  def update
    inventory_item = Inventory.find(params[:id])
    if inventory_item.update(stock: params[:stock])
      render json: { message: "Stock updated successfully" }
    else
      render json: { errors: inventory_item.errors.full_messages }, status: :unprocessable_entity
    end
  end
end