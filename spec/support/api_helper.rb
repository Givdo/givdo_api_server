module ApiHelper
  def api_user(user)
  	request.headers.merge!(user.create_new_auth_token)
  end
end
