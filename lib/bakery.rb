class Bakery
  InvalidProduct = Class.new(StandardError)
  DuplicateProduct = Class.new(StandardError)
  EmptyProductPacks = Class.new(StandardError)

  attr_accessor :products

  def initialize
    @products = {}
  end

  def add_product(product)
    raise(InvalidProduct, product) unless product.instance_of?(Product)
    raise(DuplicateProduct, "Product with code: '#{product.code}' already exists") if
      products.key?(product.code)
    raise(EmptyProductPacks, "Product should have at least 1 pack") if
      product.packs.empty?

    products[product.code] = {
      product: product
    }
  end

  def place_order(request)
    order = OrderFinder.new(products).find(request.min_amount, request.code)

    if !order.nil?
      order.to_s
    else
      'No option'
    end
  end
end