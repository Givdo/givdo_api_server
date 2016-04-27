class DeviceSerializer < ActiveModel::Serializer
  attributes :id, :enabled, :platform
end
