class ApplicationController < ActionController::Base
    helper_method :current_user
    
    protected
    def current user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
