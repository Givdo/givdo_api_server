require 'acceptance_helper'

resource "Answers" do
  header "Authorization", :token

  let(:user) { create(:user) }
  let!(:game) { create(:game, creator: user) }
  let(:token) { "Token token=#{Givdo::TokenAuth::Session.new(user, '3600').token}" }

  post "/api/v1/games/:game_id/answers" do
    parameter :trivia_id, "Trivia been answered", required: true
    parameter :trivia_option_id, "User's answer", required: false

    let(:game_id) { game.id }
    let(:trivia) { create(:trivia, :with_options) }
    let(:trivia_id) { trivia.id }
    let(:trivia_option_id) { trivia.options.first.id }

    example_request "Answering a trivia" do
      expect(status).to eq(200)
    end
  end

  post "/api/v1/games/:game_id/answers" do
    parameter :trivia_id, "Trivia been answered", required: true
    parameter :trivia_option_id, "User's answer", required: false

    let(:game_id) { game.id }
    let(:trivia_id) { trivia.id }
    let(:trivia) { create(:trivia, :with_options) }
    let(:trivia_options_id) { nil }

    example_request "Answering without an option" do
      expect(status).to eq(200)
    end
  end
end
