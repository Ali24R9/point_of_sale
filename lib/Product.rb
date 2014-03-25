class Product < ActiveRecord::Base
  has_many :purchases
  has_many :quantities
end
