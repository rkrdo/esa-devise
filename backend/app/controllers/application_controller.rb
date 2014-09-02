class ApplicationController < ActionController::Base
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  private

    # http://apidock.com/rails/v4.0.2/ActionController/HttpAuthentication/Token/token_and_options
    # Should have an authorization header that looks like this:
    # Authorization: Token token="abc", nonce="def"
    def authenticate_user_from_token!
      authenticate_with_http_token do |token, options|
        user = User.find_by(email: options[:user_email].presence)
        if user && Devise.secure_compare(user.authentication_token, token)
          sign_in user, store: false
        end
      end
    end
end
