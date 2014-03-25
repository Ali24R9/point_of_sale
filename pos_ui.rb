require 'active_record'
require 'pg'
require 'rake'
require 'rspec'
require 'active_record_migrations'
require 'shoulda-matchers'
require 'pry'

require './lib/Cashier'
require './lib/Purchase'
require './lib/Product'
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
  puts "Press E to view all employees"
  puts "Press NE to add a new employee"
  manager_answer = gets.chomp.upcase
  case manager_answer
    when "A"
      new_product
    when "V"
      view_inventory
    when "M"
      main_menu
    when "E"
      view_employees
    when "NE"
      add_employee
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

def add_employee
  puts "Enter the name of the new employee"
  new_employee_name = gets.chomp
  new_employee = Cashier.new({:name => new_employee_name})
  new_employee.save
  puts "#{new_employee_name} has been added to the system :)"
manager_menu
end

def view_employees
  puts "Here are all of your little worker bees:"
  Cashier.all.each do |employee|
    puts "#{employee.id}....#{employee.name}"
  end
  manager_menu
end

def employee_menu
  puts "enter your name to login: "
  login = gets.chomp

  cashier = Cashier.where({:name => login}).first
  if cashier == nil
    puts 'invalid login, press r to retry or any other key to go back'
    input = gets.chomp.downcase
    case input
    when 'r'
      employee_menu
    else
      main_menu
    end
  else
    ring_up(cashier)
  end

end

def ring_up(cashier)
  receipt = Receipt.create
  input = ""
  until input == 'n' do
    puts "Enter product name: "
    name = gets.chomp
    puts "Enter quantity: "
    quantity = gets.chomp
    product = Product.where({:name => name}).first
    purchase = Purchase.create({:product_id => product.id, :cashier_id => cashier.id, :receipt_id => receipt.id})
    puts "Add purchase? y/n"
    input = gets.chomp.downcase
  end
  customer_receipt = Purchase.where({:receipt_id => receipt.id})
    total = 0
    customer_receipt.each do |purchase|
      add_to_receipt = Product.where({:id => purchase.product_id}).first
      total += add_to_receipt.price.to_s.to_i
    end
    receipt.update(total: total)
    puts "Your total is #{receipt.total}"
  employee_menu
end
employee_menu
