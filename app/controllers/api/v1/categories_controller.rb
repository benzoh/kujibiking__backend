module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :set_category, only: %i[show update destroy]

      def index
        categories = Category.order(created_at: :desc).limit(20)
        render json: { categories: categories }
      end

      def show
        render json: { category: @category }
      end

      def create
        category = Category.new(category_params)

        if category.save
          render json: { category: category }
        else
          render json: { errors: category.errors }
        end
      end

      def update
        if @category.update(category_params)
          render json: {category: @category}
        else
          render json: {errors: @category.errors}
        end
      end

      def destroy
        # TODO
      end

      private

      def set_category
        @category = Category.find(params[:id])
      end

      def category_params
        params.permit(:name, :slug)
      end
    end
  end
end
