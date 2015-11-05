require 'rails_helper'

RSpec.describe TriviaController, type: :controller do
  let(:current_user) { create(:user) }
  let(:trivia) { build(:trivia, :id => 10, :question => 'Who is the director of Casino?') }

  describe 'GET /:id' do
    subject { get :show, :id => 10, :format => :json }
    before { allow(Trivia).to receive(:find).with('10').and_return(trivia) }

    it_behaves_like 'an authenticated only action'

    it 'renders a json of the requested trivia when authenticated' do
      api_user current_user

      expect(subject.body).to serialize_object(trivia).with(TriviaSerializer)
    end
  end

  describe 'GET /raffle' do
    subject { get :raffle }

    it_behaves_like 'an authenticated only action'

    it 'raffles in the current user scope' do
      expect(TriviaRaffle).to receive(:next).with(current_user).and_return(trivia)

      api_user current_user

      expect(subject.body).to serialize_object(trivia).with(TriviaSerializer)
    end
  end

  describe 'POST /:id/answer' do
    let(:answer) { build(:answer) }
    subject { post :answer, :id => 10, :option_id => 10, :format => :json }
    before { allow(Trivia).to receive(:find).with('10').and_return(trivia) }

    it_behaves_like 'an authenticated only action'

    it 'answers the trivia with the current user' do
      api_user current_user

      expect(trivia).to receive(:answer!).with(current_user, 10).and_return(answer)

      expect(subject).to be_success
      expect(subject.body).to serialize_object(answer).with(AnswerSerializer)
    end
  end
end
