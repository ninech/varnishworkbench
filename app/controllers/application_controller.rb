class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
    

    private
        def remote_ip
            if request.headers.key?('HTTP_X_CACHE_FOR')
                request.headers['HTTP_X_CACHE_FOR']
            else
                request.remote_ip
            end
        end
end
