class SidesController < ApplicationController
  def index
    sides = Side.all
    render json: sides, status: :ok
  end

  def show
    side = Side.find(params[:id])
    render json: side, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Side not found" }, status: :not_found
  end

  def create
    side = Side.new(side_params)
    if side.save
      render json: side, status: :created
    else
      render json: { errors: side.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    side = Side.find(params[:id])
    if side.update(side_params)
      render json: side, status: :ok
    else
      render json: { errors: side.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    side = Side.find(params[:id])
    side.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Side not found" }, status: :not_found
  end

  private

  def side_params
    params.require(:side).permit(:name, :price, :quantity)
  end
end