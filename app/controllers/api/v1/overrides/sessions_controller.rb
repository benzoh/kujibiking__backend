module Api
  module V1
    module Overrides
      class SessionsController < ::DeviseTokenAuth::SessionsController

        # override this method to customise how the resource is rendered. in this case an ActiveModelSerializers 0.10 serializer.
        def render_create_success
          # raise
          render json: { data: ActiveModelSerializers::SerializableResource.new(@resource).as_json }
        end
      end
    end
  end
end