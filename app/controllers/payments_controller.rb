class PaymentsController < ApplicationController
  before_filter :authenticate_user!

  def token
    token = Braintree::ClientToken.generate
    render :json => {:token => token}
  end

  def create
    ProcessPaymentJob.perform_later(current_user, 'credit-card-nonce', '10.00')

    render :json => {:success => true}
  end
end
