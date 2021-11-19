class SpicesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_no_spice_error
  
  def index
    render json: Spice.all, status: :ok
  end

  def show
    spice = find_spice
    render json: spice, status: :ok
  end

  def update
    spice = find_spice
    spice.update(spice_params)
    render json: spice, status: :accepted
  end

  def create
    spice = Spice.create(spice_params)
    render json: spice, status: :created
  end

  def destroy
    spice = find_spice
    spice.destroy
    head :no_content
  end

  private
  
  def find_spice
    Spice.find(params[:id])
  end

  def render_no_spice_error
    render json: { error: "Spice not found" }, status: :not_found
  end

  def spice_params
    params.permit(:title, :image, :description, :notes, :rating)
  end
end
