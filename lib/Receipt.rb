class Receipt < ActiveRecord::Base
  has_many :purchases
end
