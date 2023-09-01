module Api
  module V1
    class SessionsController < Devise::SessionsController
      skip_before_action :verify_authenticity_token, if: :json_request?
      respond_to :json
      def create
        user = User.find_by(email: session_params[:email])
        if user&.valid_password?(session_params[:password])
          render json: { message: 'Login successful.', id: user.id, name: user.name }
        else
          render json: { message: 'Invalid email or password.' }, status: :unprocessable_entity
        end
      end

      private

      def session_params
        params.require(:user).permit(:email, :password)
      end

      protected

      def json_request?
        request.format.json?
      end
    end
  end
end
