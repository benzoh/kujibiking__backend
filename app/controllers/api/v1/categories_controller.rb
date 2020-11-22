module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :set_category, only: %i[show update destroy]

      def index
        # TODO
        categories = Category.order(created_at: :desc).limit(20)
        render json: { categories: categories }
      end

      def show
        # TODO
      end

      def create
        # TODO
      end

      def update
        # TODO
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
