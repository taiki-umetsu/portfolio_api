# frozen_string_literal: true

class Api::V1::AboutsController < ApplicationController
  before_action :set_about, only: %i[show update]

  def index
    abouts = [About.instance]
    response.headers["X-Total-Count"] = 1
    render json: abouts
  end

  def show
    render json: @about
  end

  def update
    if @about.update(about_params)
      render json: @about, status: :ok
    else
      render json: { errors: @about.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_about
    @about = About.find(params[:id])
  end

  def about_params
    params.require(:about).permit(:description)
  end
end
