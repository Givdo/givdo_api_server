class OauthCallbackController < DeviseTokenAuth::OmniauthCallbacksController
  def assign_provider_attrs(user, auth_hash)
    super

    user.assign_attributes(:provider_token => auth_hash['credentials'])
  end
end
