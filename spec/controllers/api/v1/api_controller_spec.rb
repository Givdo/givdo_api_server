require 'rails_helper'

RSpec.describe Api::V1::ApiController, :type => :controller do
  let(:user) { create(:user) }

  controller do
    def index
      render :text => 'you are in'
    end
  end

  it "authenticates the user by token"
end
