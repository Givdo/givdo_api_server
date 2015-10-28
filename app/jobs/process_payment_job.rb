class ProcessPaymentJob < ActiveJob::Base
  queue_as :default

  def perform(user, nounce, amount)
    create_customer(user) unless user.braintree_customer_id
    create_payment_method(user, nounce) if nounce
    process_payment(user, amount) if amount
  end

  private

  def create_customer(user, nounce)
    result = Braintree::Customer.create

    user.update_attribute(:braintree_customer_id, result.customer.id)
  end

  def create_payment_method(user, nounce)
    result = Braintree::PaymentMethod.create({
      :customer_id => user.braintree_customer_id,
      :payment_method_nounce => nounce,
      :options => { :make_deault => true, :verify_card => true }
    })

    user.update_attribute(:braintree_payment_method_token, result.payment_method.token)
  end

  def process_payment(user, amount)
    Braintree::Transaction.sale({
      :amount => amount,
      :payment_method_token => user.braintree_payment_method_token,
      :options => { :submit_for_settlement => true }
    })
  end
end
