# frozen_string_literal: true

require 'byebug'

module Api
  module V1
    #
    # profiles controller
    #
    class ProfilesController < ApplicationController
      before_action :set_profile, only: %i[show update destroy]

      def index
        render json: { status: 'SUCCESS' }
      end

      def create
        # byebug
        @profile = Profile.new(profile_params)
        @profile.user = current_api_v1_user

        if @profile.save
          render json: @profile
        else
          render json: { errors: @profile.errors }
        end
      end

      def show
        render json: @profile
      end

      def update
        if @profile.save
          render json: profile
        else
          render json: { errors: @profile.errors }
        end
      end

      def destroy
        @profile.destroy
      end

      private

      def set_profile
        user = User.find(params[:id])
        byebug
        @profile = user.profile
      end

      def profile_params
        params.permit(:name, :user_id)
      end
    end
  end
end
