require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do
  describe 'POST /games/:game_id/answers' do
    it_behaves_like 'an authenticated only action' do
      subject { post(:create, :game_id => 1) }
    end

    describe 'successful call' do
      let(:answer) { build(:answer) }
      let(:user) { build(:user) }
      let(:game) { double }
      before do
        allow(Game).to receive(:find).with('10').and_return(game)
        api_user(user)
      end
      subject do
        post(:create, {
          :game_id => 10,
          :trivia_id => 15,
          :option_id => 25,
          :format => :json
        })
      end

      it 'answers the trivia in the current game' do
        expect(game).to receive(:answer!).with(user, {
          :trivia_id => 15,
          :option_id => 25
        }).and_return(answer)

        expect(subject).to be_success
        expect(subject.body).to serialize_object(answer).with(AnswerSerializer, :include => 'game,game.trivia,game.trivia.options')
      end
    end
  end
end
