require 'active_record'
require 'pg'
require 'rake'
require 'rspec'
require 'active_record_migrations'
require 'shoulda-matchers'
require 'pry'

require './lib/Cashier'
require './lib/Item'
require './lib/Product'
require './lib/Manager'
require './lib/Receipt'
require './lib/Quantity'


database_configuration = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configuration['development']
ActiveRecord::Base.establish_connection(development_configuration)
def welcome
  puts "Hi Welcome to the POS system\n"
  main_menu
end
def main_menu
  puts "Press M for the manager menu, press E for the employee menu"
  puts "Press X to leave :(...."
  who_is = gets.chomp.upcase
  case who_is
    when "M"
      manager_menu
    when "E"
      employee_menu
    when "X"
      puts "Bye Bye now!"
    else
      puts "Please read the directions and try again"
      main_menu
    end
  end

def manager_menu
  puts "Press A to add a new item"
  puts "Press V to view your inventory"
  puts "Press M to go to main menu"
  manager_answer = gets.chomp.upcase
  case manager_answer
    when "A"
      new_product
    when "V"
      view_inventory
    when "M"
      main_menu
  end
end

def new_product
  puts "Enter product name: "
  product_name = gets.chomp
  puts "What is this item's cost?"
  price = gets.chomp.to_f
  product = Product.new({:name => product_name, :price => price})
  product.save
  puts "Product added"
  puts "How many of #{product_name} would you like to order?"
  quantity = gets.chomp.to_i
  duplicate = Quantity.find_by product_id: product.id
  if duplicate == nil
    inventory = Quantity.new(:product_id => product.id, :quantity => quantity)
    inventory.save
  else
    current = duplicate.quantity.to_i
    total = current + quantity
    duplicate.update(:quantity => total)
  end
  main_menu
end

def view_inventory
  system "clear"
  puts "Here are all of your products:"
  Quantity.all.each do |product|
    product_name = Product.where(:id => product.product_id).first
    puts "#{product_name.name}......#{product.quantity}"
  end
  puts "**************************\n"
  main_menu
end
welcome
