require 'active_record'
require 'pg'
require 'rake'
require 'rspec'
require 'active_record_migrations'
require 'shoulda-matchers'
require 'pry'

require 'Cashier'
require 'Item'
require 'Product'
require 'Manager'
require 'Receipt'
require 'Quantity'

database_configuration = YAML::load(File.open('./db/config.yml'))
test_configuration = database_configuration['test']
ActiveRecord::Base.establish_connection(test_configuration)

RSpec.configure do |config|
  config.after(:each) do
    Cashier.all.each { |cashier| cashier.destroy }
    Item.all.each { |item| item.destroy }
    Product.all.each { |product| product.destroy }
    Manager.all.each { |manager| manager.destroy }
    Receipt.all.each { |receipt| receipt.destroy }
  end
end
