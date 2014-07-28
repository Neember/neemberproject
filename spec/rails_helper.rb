# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'webmock/rspec'
require 'fakeweb'

WebMock.disable_net_connect!(allow_localhost: true)

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  config.include FactoryGirl::Syntax::Methods
  config.include(FeatureHelper, type: :feature)
  config.include Devise::TestHelpers, type: :controller

  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
    :provider => 'google_oauth2',
    :uid => '123456789',
    :info => {
      :email => 'martin@futureworkz.com',
      :first_name => 'John',
      :last_name => 'Doe'
    },
  })

  FakeWeb.register_uri(:get, 'http://neemberclient.herokuapp.com/clients.json',
    body: {
      clients: [
        { id: 2, company_name: 'DualRanked', first_name: 'Gabriel', last_name: 'Bunner' },
        { id: 3, company_name: 'LunchKaki', first_name: 'Melvin', last_name: 'Tan' }
      ]
    }.to_json
  )

  FakeWeb.register_uri(:get, 'http://neemberclient.herokuapp.com/clients/2.json',
    body: {client: { id: 2, company_name: 'DualRanked', first_name: 'Gabriel', last_name: 'Bunner', designation: 'Owner', email: 'gabriel@example.com', phone: '4456-5869', address: '50 DEF Street Malaysia' }}.to_json
  )

end
