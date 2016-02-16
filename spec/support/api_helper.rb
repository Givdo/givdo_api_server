module ApiHelper
  def auth_header(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end

  def api_user(user)
    token = UserToken.generate(user, false)
    request.env['HTTP_AUTHORIZATION'] = auth_header(token)
    allow(UserToken).to receive(:authenticate).with(token).and_return(user)
    allow(BetaAccess).to receive(:granted?).and_return(true)
  end

  def api_logout
    allow(UserToken).to receive(:authenticate).and_return(nil)
  end

  def serialize(object, serializer_klass, options={})
    if object.respond_to?(:each)
      options = options.merge({:serializer => serializer_klass})
      serializer_klass = ActiveModel::Serializer::CollectionSerializer
    end
    serializer = serializer_klass.new(object, options)
    adapter = ActiveModel::Serializer::Adapter.create(serializer, options)
    adapter.as_json
  end
end
