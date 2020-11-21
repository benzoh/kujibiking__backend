module Api
  module V1
    class LotteriesController < ApplicationController
      def index
        lotteries = Lottery.order(created_at: :desc)
        # raise
        render json: { status: 'SUCCESS', message: 'Loaded lotteries', data: lotteries }
      end
    end
  end
end
