RSpec::Matchers.define :serialize_object do |object|
  match do |actual|
    expected = serialize(object, @serializer_klass, @options).to_json
    expected.eql?(actual.is_a?(String) ? actual : actual.to_json)
  end

  chain :with do |serializer_klass, options={}|
    @serializer_klass = serializer_klass
    @options = options
  end
end

RSpec::Matchers.define :serialize_collection do |*objects|
  match do |actual|
    expect(actual).to serialize_object(objects.flatten).with(@serializer_klass, @options)
  end

  chain :with do |serializer_klass, options={}|
    @serializer_klass = serializer_klass
    @options = options
  end
end

RSpec::Matchers.define :serialize_id_and_type do |id, type|
  match do |json|
    expect(json[:data]).to include({:id => id, :type => type})
  end
end

RSpec::Matchers.define :serialize_attribute do |name|
  match do |json|
    expect(json[:data][:attributes][name]).to eql @value
  end

  chain :with do |value|
    @value = value
  end
end

RSpec::Matchers.define :serialize_link do |name|
  match do |json|
    expect(json[:data][:links][name][:href]).to eql @href
  end

  chain :with do |href|
    @href = href
  end
end

RSpec::Matchers.define :serialize_included do |object|
  match do |actual|
    expected = serialize(object, @serializer, @options)
    expect(actual[:included]).to include(expected[:data])
  end

  chain :with do |serializer, options={}|
    @serializer, @options = serializer, options
  end
end
