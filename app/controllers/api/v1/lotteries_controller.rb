module Api
  module V1
    class LotteriesController < ApplicationController
      before_action :set_lottery, only: %i[show update destroy]
      
      def index
        lotteries = Lottery.order(created_at: :desc)
        # raise
        render json: { status: 'SUCCESS', message: 'Loaded lotteries', data: lotteries }
      end

      def show
        render json: @lottery
      end

      private

      def set_lottery
        @lottery = Lottery.find(params[:id])
      end
    end
  end
end
