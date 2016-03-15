module ApiHelper
  def auth_header(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end

  def api_user(user)
    allow(user).to receive(:to_sgid).and_return('test.user')
    session = Givdo::TokenAuth::Session.new(user, false)
    request.env['HTTP_AUTHORIZATION'] = auth_header(session.token)
    allow(Givdo::TokenAuth).to receive(:recover).with(session.token).and_return(session)
    allow(BetaAccess).to receive(:granted?).and_return(true)
  end

  def api_logout
    allow(Givdo::TokenAuth).to receive(:recover).and_return(nil)
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
