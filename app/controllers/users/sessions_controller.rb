class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: {
      user: resource,
      jwt: Devise::JWT::Serializer.new(resource).serializable_hash
    }, status: :created
  end
end
