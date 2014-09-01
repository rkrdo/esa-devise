class User < ActiveRecord::Base
  before_save :ensure_auth_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private

    def ensure_auth_token
      self.authentication_token = generate_auth_token if authentication_token.blank?
    end

    def generate_auth_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(authentication_token: token).first
      end
    end
end
