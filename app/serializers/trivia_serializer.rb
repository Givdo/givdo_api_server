class TriviaSerializer < ActiveModel::Serializer
  attributes :id, :question

  has_many :_options, :key => :options, :serializer => TriviaOptionSerializer

  def _options
    object.options.shuffle
  end
end
