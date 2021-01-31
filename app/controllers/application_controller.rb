class ApplicationController < ActionController::Base
    helper_method :current_user
    helper_method :logged

    protected
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged?
        current_user != nil
    end
end
