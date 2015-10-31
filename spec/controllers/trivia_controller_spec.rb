require 'rails_helper'

RSpec.describe TriviaController, type: :controller do
  describe "GET /:trivia_id" do
    let(:body) { JSON.parse(subject.body) }
    let(:trivia) { build(:trivia, question: 'Who is the director of Casino?') }
    before { expect(Trivia).to receive(:find).with('10').and_return(trivia) }
    subject { get :show, :id => 10, :format => :json }

    it 'renders a json of the requested trivia' do
      expect(body['question']).to eql 'Who is the director of Casino?'
    end
  end
end
