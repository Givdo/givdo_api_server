require 'rails_helper'

RSpec.describe TriviaController, type: :controller do
  describe "GET /:id" do
    let(:trivia) { build(:trivia, id: 10, question: 'Who is the director of Casino?') }
    before { expect(Trivia).to receive(:find).with('10').and_return(trivia) }
    subject { get :show, :id => 10, :format => :json }

    it 'renders a json of the requested trivia' do
      expect(subject.body).to serialize_object(trivia).with(TriviaSerializer)
    end
  end
end
