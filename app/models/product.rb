class Product < ActiveRecord::Base
  has_and_belongs_to_many :orders, join_table: 'product_orders'
end
