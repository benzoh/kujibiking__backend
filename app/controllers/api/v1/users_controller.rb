# frozen_string_literal: true

module Api
  module V1
    #
    # users controller
    #
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show update destroy]

      def index
        users = User.order(created_at: :desc).limit(20)
        authorize users

        render json: users
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
          render json: { errors: user.errors }
        end
      end

      def update
        authorize @user
        if @user.save
          render json: @user
        else
          render json: { errors: user.errors }
        end
      end

      def destroy
        authorize @user
        @user.destroy
      end

      private

      def set_user
        # byebug
        @user = User.find(params[:id])

        render nothing: true, status: :not_found if @user.nil?
      end

      def user_params
        params.permit(:name, :email)
      end
    end
  end
end
