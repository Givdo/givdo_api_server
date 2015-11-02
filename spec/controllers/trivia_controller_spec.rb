require 'rails_helper'

RSpec.describe TriviaController, type: :controller do
  let(:current_user) { create(:user) }
  let(:trivia) { build(:trivia, :id => 10, :question => 'Who is the director of Casino?') }
  before do
    allow(Trivia).to receive(:find).with('10').and_return(trivia)
  end

  describe 'GET /:id' do
    subject { get :show, :id => 10, :format => :json }

    it 'renders a json of the requested trivia when authenticated' do
      api_user current_user

      expect(subject.body).to serialize_object(trivia).with(TriviaSerializer)
    end

    it 'does not allow unauthenticated users' do
      expect(subject).to be_unauthorized
    end
  end

describe 'POST /:id/answer' do
    let(:answer) { build(:answer) }
    subject { post :answer, :id => 10, :option_id => 10, :format => :json }

    it 'answers the trivia with the current user' do
      api_user current_user

      expect(trivia).to receive(:answer!).with(current_user, 10).and_return(answer)

      expect(subject).to be_success
      expect(subject.body).to serialize_object(answer).with(AnswerSerializer)
    end
  end
end
