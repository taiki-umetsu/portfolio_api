# frozen_string_literal: true

class Api::V1::SkillsController < ApplicationController
  include Paginatable
  before_action :set_skill, only: %i[show update destroy]

  def index
    params = pagination_params
    skills = Skill.sorted(params[:sort], params[:order]).paginated(params[:start], params[:end_param])
    response.headers["X-Total-Count"] = skills.count
    render json: skills
  end

  def show
    render json: @skill
  end

  def create
    skill = Skill.new(skill_params)
    if skill.save
      render json: skill, status: :created
    else
      render json: { errors: skill.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @skill.update(skill_params)
      render json: @skill, status: :ok
    else
      render json: { errors: @skill.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @skill.destroy
      render json: { message: "delete sucessfully" }, status: :ok
    else
      render json: { errors: @skill.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_skill
    @skill = Skill.find(params[:id])
  end

  def skill_params
    params.require(:skill).permit(:title, :level)
  end
end
