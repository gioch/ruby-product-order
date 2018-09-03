require 'order'
require 'order_request'
require 'order_finder'
require 'product'
require 'product_pack'
require 'bakery'

describe Bakery do
  subject(:bakery) { described_class.new }
  let(:pack_1) { ProductPack.new(3, 4.5) }
  let(:pack_2) { ProductPack.new(5, 18) }
  let(:product_1) { Product.new('Croissant', 'CF') }
  let(:order) { Order.new }

  describe '#add_product' do
    it 'raises an exception if product is invalid' do
      expect { bakery.add_product(['CF']) }
        .to raise_exception(Bakery::InvalidProduct)
    end

    it 'does not allow product with duplicate codes' do
      product_1.add_product_pack(pack_1)
      bakery.add_product(product_1)

      expect { bakery.add_product(product_1) }
        .to raise_exception(Bakery::DuplicateProduct)
    end

    it 'does not allow to add product with no packs' do
      expect { bakery.add_product(product_1) }
        .to raise_exception(Bakery::EmptyProductPacks)
    end
  end

  describe '#place_order' do
    before(:each) do
      product_1.add_product_pack(pack_1)
      product_1.add_product_pack(pack_2)
      bakery.add_product(product_1)
    end

    it 'returns "No option" when there are no available packagings' do
      expect(bakery.place_order(OrderRequest.new(7, 'CF')))
        .to eq('No option')
    end

    it 'returns "No option" when product with specified code does not exist' do
      expect(bakery.place_order(OrderRequest.new(7, 'CF4')))
        .to eq('No option')
    end

    it 'returns correct Order if optimal packaging is available' do
      order.add_item(product_1.code, 3, pack_1.min_amount, pack_1.price)
      order.add_item(product_1.code, 1, pack_2.min_amount, pack_2.price)

      expect(bakery.place_order(OrderRequest.new(14, 'CF')))
        .to eq(order.to_s)
    end
  end
end
