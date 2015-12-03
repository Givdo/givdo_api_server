module ApiHelper
  def auth_header(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end

  def api_user(user)
    token = UserToken.generate(user, false)
    request.env['HTTP_AUTHORIZATION'] = auth_header(token)
    allow(UserToken).to receive(:authenticate).with(token).and_return(user)
  end

  def serialize(object, serializer_klass)
    serializer = serializer_klass.new(object)
    adapter = ActiveModel::Serializer::Adapter.create(serializer)
    adapter.as_json
  end
end
