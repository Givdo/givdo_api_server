RSpec::Matchers.define :serialize_object do |object|
  match do |json|
    serializer = @serializer_klass.new(object, @options)
    adapter = ActiveModel::Serializer::Adapter.create(serializer)
    adapter.to_json.eql?(json.is_a?(String) ? json : json.to_json)
  end

  chain :with do |serializer_klass, options={}|
    @serializer_klass = serializer_klass
    @options = options
  end
end

RSpec::Matchers.define :serialize_collection do |*objects|
  match do |json|
    serializer = ActiveModel::Serializer::ArraySerializer
    options = {:serializer => @serializer_klass}
    expect(json).to serialize_object(objects.flatten).with(serializer, options)
  end

  chain :with do |serializer_klass|
    @serializer_klass = serializer_klass
  end
end
