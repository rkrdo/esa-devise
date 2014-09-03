class Api::RegistrationsController < Api::ApiController
  skip_before_filter :authenticate_user_from_token!
  skip_before_filter :authenticate_user!

  respond_to :json

  def create
    user = User.new(user_params)
    if user.save
      data = { user_token: user.authentication_token, user_email: user.email }
      render json: data, status: 201
    else
      warden.custom_failure!
      render json: user.errors, status: 422
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
