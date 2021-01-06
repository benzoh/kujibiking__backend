module Api
  module V1
    class LotteriesController < ApplicationController
      before_action :set_lottery, only: %i[show update destroy]

      def index
        lotteries = Lottery.includes(:user).order(created_at: :desc)
        authorize lotteries
        # raise
        render json: { status: 'SUCCESS', message: 'Loaded lotteries', data: lotteries }
      end

      def show
        authorize @lottery
        render json: @lottery
      end

      def create
        authorize Lottery
        lottery = current_api_v1_user.lotteries.new(lottery_params)
        # lottery = Lottery.new(lottery_params)

        if lottery.save
          render json: lottery
        else
          render json: { errors: lottery.errors }
        end
      end

      def update
        authorize @lottery
        if @lottery.save
          render json: @lottery
        else
          render json: { errors: @lottery.errors }
        end
      end

      def destroy
        authorize @lottery
        @lottery.destroy
      end

      private

      def set_lottery
        @lottery = Lottery.find(params[:id])
      end

      def lottery_params
        params.permit(:result, :memo)
      end
    end
  end
end
