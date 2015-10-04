class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  private
    
  def get_graph
    if @graph.nil?
      oauth = Koala::Facebook::OAuth.new Facebook::APP_ID, Facebook::SECRET
      app_access_token = oauth.get_app_access_token
      @graph = Koala::Facebook::API.new app_access_token
    end
    @graph
  end
  helper_method :get_graph
  
end
