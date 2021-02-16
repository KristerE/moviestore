class Api::V1::CategoriesController < ApplicationController
  def index
    categories=Category.all
    render json: {status: 'SUCCESS', message:'Categories', data:categories}, status: :ok
  end
end
