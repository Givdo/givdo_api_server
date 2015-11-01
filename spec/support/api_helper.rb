module ApiHelper
  def api_user(user)
  	request.headers.merge!(user.create_new_auth_token)
  end

  def serialize(object, serializer_klass)
    serializer = serializer_klass.new(object)
    adapter = ActiveModel::Serializer::Adapter.create(serializer)
    adapter.as_json
  end
end
