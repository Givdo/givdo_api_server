module Givdo
  module Facebook
    module User
      def self.get(data)
        user_attr = map_attributes(data).except('id')
        ::User.for_provider!(:facebook, data['id'], user_attr)
      end

      def self.list(list)
        attributes = list.map{|data| map_attributes(data) }
        ::User.for_provider_batch!(:facebook, attributes)
      end

      private

      def self.map_attributes(data)
        data.dup.tap do |user|
          user['image'] ||= picture_url(data['id'])
          user['cover'] = user['cover']['source'] if user.has_key?('cover')
        end
      end

      def self.picture_url(uid)
        "https://graph.facebook.com/#{uid}/picture"
      end
    end
  end
end
