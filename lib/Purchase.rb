class Purchase < ActiveRecord::Base
  belongs_to :cashier
  belongs_to :receipt
  belongs_to :product
end



# select all purchases with the same receipt id
# from that -> select all product_id's --> products.price
