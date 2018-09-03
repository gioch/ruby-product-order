require 'optparse'
require_relative '../lib/bakery'
require_relative '../lib/product'
require_relative '../lib/product_pack'
require_relative '../lib/order'
require_relative '../lib/order_request'
require_relative '../lib/order_finder'

bakery = Bakery.new

product_1 = Product.new('Vegemite Scroll', 'VS5')
product_1.add_product_pack(ProductPack.new(3, 6.99))
product_1.add_product_pack(ProductPack.new(5, 8.99))

product_2 = Product.new('Blubery Muffin', 'MB11')
product_2.add_product_pack(ProductPack.new(2, 9.95))
product_2.add_product_pack(ProductPack.new(5, 16.95))
product_2.add_product_pack(ProductPack.new(8, 24.95))

product_3 = Product.new('Croissant', 'CF')
product_3.add_product_pack(ProductPack.new(3, 5.95))
product_3.add_product_pack(ProductPack.new(5, 9.95))
product_3.add_product_pack(ProductPack.new(9, 16.99))

bakery.add_product(product_1)
bakery.add_product(product_2)
bakery.add_product(product_3)


# NOTE:
# Current implementation works only for single-product per input

p "Enter amount and product code:"
ARGF.each do |line|
  begin
    puts bakery.place_order(OrderRequest.parse(line))
  rescue StandardError
    p 'No option'
  end

  puts "\nEnter amount and product code:"
end