require 'order'
require 'order_request'
require 'order_finder'
require 'product'
require 'product_pack'
require 'bakery'

describe OrderFinder do
  let(:bakery) { Bakery.new }
  let(:pack_1) { ProductPack.new(3, 4.5) }
  let(:pack_2) { ProductPack.new(5, 18) }
  let(:product_1) { Product.new('Croissant', 'CF') }
  let(:order) { Order.new }

  describe '#find' do
    it 'return nil if product with specified code not found' do
      product_1.add_product_pack(pack_1)
      product_1.add_product_pack(pack_2)
      bakery.add_product(product_1)

      order_finder = OrderFinder.new(bakery.products)

      expect(order_finder.find(10, 'CF1')).to eq(nil)
    end

    it 'returns new Order if optimal packaging found' do
      product_1.add_product_pack(pack_1)
      product_1.add_product_pack(pack_2)
      bakery.add_product(product_1)

      order.add_item(product_1.code, 3, pack_1.min_amount, pack_1.price)
      order.add_item(product_1.code, 1, pack_2.min_amount, pack_2.price)
      order_finder = OrderFinder.new(bakery.products)

      expect(order_finder.find(14, 'CF')).to eq(order)
    end
  end
end
