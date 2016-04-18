require 'rails_helper'

RSpec.describe Player::SaveAnswer, type: :service do
  subject(:service) { described_class }

  it "creates an answer for the player" do
    player = build(:player)
    answer_params = attributes_for(:answer)

    expect(player).to receive(:answer!).with(answer_params)

    service.call(player, answer_params)
  end

  it "reaturns the answer" do
    player = build(:player)
    answer = build(:answer)
    answer_params = answer.attributes

    expect(player).to receive(:answer!).with(answer_params).and_return(answer)

    service.call(player, answer_params)
  end

  context "when answers don't reach rounds limit" do
    it "doesn't finish the player" do
      player = double(Player, has_rounds?: true)
      answer_params = attributes_for(:answer)

      expect(player).to receive(:answer!).with(answer_params)
      expect(Player::Finish).not_to receive(:call).with(player)

      service.call(player, answer_params)
    end
  end

  context "when answers reach rounds limit" do
    it "finishes the player" do
      player = double(Player, has_rounds?: false)
      answer_params = attributes_for(:answer)

      expect(player).to receive(:answer!).with(answer_params)
      expect(Player::Finish).to receive(:call).with(player)

      service.call(player, answer_params)
    end
  end
end
