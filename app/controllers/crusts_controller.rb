class CrustsController < ApplicationController

  def index
    crusts = Crust.all
    render json: crusts, status: :ok
  end

  def show
    crust = Crust.find(params[:id])
    render json: crust, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Crust not found" }, status: :not_found
  end

  def create
    crust = Crust.new(crust_params)
    if crust.save
      render json: crust, status: :created
    else
      render json: { errors: crust.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    crust = Crust.find(params[:id])
    if crust.update(crust_params)
      render json: crust, status: :ok
    else
      render json: { errors: crust.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    crust = Crust.find(params[:id])
    crust.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Crust not found" }, status: :not_found
  end

  private

  def crust_params
    params.require(:crust).permit(:name)
  end
end