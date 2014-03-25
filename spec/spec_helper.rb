require 'active_record'
require 'pg'
require 'rake'
require 'rspec'
require 'active_record_migrations'
require 'shoulda-matchers'
require 'pry'

require 'Cashier'
require 'Purchase'
require 'Product'
require 'Receipt'
require 'Quantity'

database_configuration = YAML::load(File.open('./db/config.yml'))
test_configuration = database_configuration['test']
ActiveRecord::Base.establish_connection(test_configuration)

RSpec.configure do |config|
  config.after(:each) do
    Cashier.all.each { |cashier| cashier.destroy }
    Purchase.all.each { |purchase| purchase.destroy }
    Product.all.each { |product| product.destroy }
    Receipt.all.each { |receipt| receipt.destroy }
    Quantity.all.each { |quantity| quantity.destroy }

  end
end
