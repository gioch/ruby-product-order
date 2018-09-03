require 'order'
require 'order_request'
require 'order_finder'
require 'product'
require 'product_pack'
require 'bakery'

describe Product do
  subject(:product) { described_class.new('Croissant', 'CF') }
  let(:pack_1) { ProductPack.new(3, 4.5) }
  let(:pack_2) { ProductPack.new(5, 18) }

  describe '#add_product_pack' do
    it 'raises an exception if product is invalid' do
      expect { product.add_product_pack(['CF']) }
        .to raise_exception(Product::InvalidProductPack)
    end

    it 'does not allow equal product packs' do
      product.add_product_pack(pack_1)

      expect { product.add_product_pack(pack_1) }
        .to raise_exception(Product::DuplicateProductPack)
    end
  end

  describe '#pack_min_amounts' do
    it 'returns array of all available minimal packaging amount numbers' do
      product.add_product_pack(pack_1)
      product.add_product_pack(pack_2)

      expect(product.pack_min_amounts).to eq([3, 5])
    end
  end
end
