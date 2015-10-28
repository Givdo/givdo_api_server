settings = Rails.application.secrets.braintree

Braintree::Configuration.environment = settings['environment'].to_sym
Braintree::Configuration.merchant_id = settings['merchant_id']
Braintree::Configuration.private_key = settings['private_key']
Braintree::Configuration.public_key  = settings['public_key']
