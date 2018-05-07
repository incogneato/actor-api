class Api::V1::ActorsController < ApplicationController
  before_action :filter_search, only: :search

  def index
    @actors = Actor
      .includes(:most_known_work)
      .order('most_known_works.rating DESC')
      .paginate(page: params[:page], per_page: 25)
  end

  def search
  end

  private

  def filter_search
    if params_safe?(params)
      @actors = Actor
        .where(birth_month: params[:birth_month].to_i, birth_day: params[:birth_day].to_i)
        .paginate(page: params[:page], per_page: 25)
    else
      render json: {
        status: 422,
        message: 'Sorry, we had a problem.'
      },
        status: :unprocessable_entity
    end
  end

  def params_safe?(params)
    ('01'..'12').to_a.include?(params[:birth_month]) && ('01'..'31').to_a.include?(params[:birth_day])
  end
end
