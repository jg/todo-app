require 'digest/sha1'
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |given_username, given_password|
      if user = User.find_by_email(given_username)
        password = user.encrypted_password
        if Digest::SHA1.hexdigest(given_password) == password
          @current_user = user
          true
        else
          false
        end
      end
    end
  end

  def current_user
    @current_user
  end
end
