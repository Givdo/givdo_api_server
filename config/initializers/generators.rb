Rails.application.config.generators do |generate|
  generate.helper false
  generate.scss false
  generate.assets false
  generate.javascript_engine false
  generate.request_specs false
  generate.routing_specs false
  generate.stylesheets false
  generate.javascripts false
  generate.view_specs false
  generate.test_framework :rspec
end
