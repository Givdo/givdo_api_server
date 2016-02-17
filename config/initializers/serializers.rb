ActiveModel::Serializer.config.adapter = :json_api
ActiveModel::Serializer::Adapter::JsonApi::Link.send(:include, Rails.application.routes.url_helpers)
