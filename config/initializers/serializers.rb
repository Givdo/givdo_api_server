ActiveModel::Serializer.config.tap do |config|
  config.adapter = :json_api
  config.key_transform = :underscore
end
