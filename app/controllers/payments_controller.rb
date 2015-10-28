class PaymentsController < ApplicationController
  def token
    token = Braintree::ClientToken.generate
    render json: {:token => token}
  end
end
