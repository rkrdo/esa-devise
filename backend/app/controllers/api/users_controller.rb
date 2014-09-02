module Api
  class UsersController < ApiController
    respond_to :json

    def index
      respond_with User.all
    end

  end
end
