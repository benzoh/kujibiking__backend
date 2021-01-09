# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.all
        authorize users

        render json: { status: 'SUCCESS', message: 'Lodaded users', data: users }
      end

      def show
        authorize @user
        render json: @user
      end

      def create
        authorize User
        user = User.new(user_params)

        if user.save
          render json: user
        else
          render json: { errors: lottery.errors }
        end
      end

      def update
        authorize @user
        if @lottery.save
          render json: @user
        else
          render json: { errors: lottery.errors }
        end
      end

      def destroy
        authorize @user
        @user.destroy
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.permit(:name, :email)
      end
    end
  end
end
