class OrderFinder
  attr_accessor :products

  def initialize(products)
    @products = products
    @product = {}
  end

  def find(requested_amount, product_code)
    if !products[product_code].nil?
      @product = products[product_code][:product]

      return if @product.nil?

      optimal_packaging = optimal_packaging(
        requested_amount, @product.pack_min_amounts
      )

      create_order(optimal_packaging)
    end
  end

  private

  def create_order(optimal_packaging)
    return if optimal_packaging.empty? || optimal_packaging.nil?

    order = Order.new

    optimal_packaging.each do |min_pack_amount, total_pack_count|
      pack = @product.packs.find{ |p| p.min_amount == min_pack_amount }
      order.add_item(
        @product.code, total_pack_count, min_pack_amount, pack.price
      )
    end

    order
  end

  def optimal_packaging(requested_amount, min_amounts)
    bundles = {}
    multiples = multiples(requested_amount, min_amounts)
    combined_multiples = multiples.values.flatten

    min_amounts.sort.reverse.each do |min_amount|
      if requested_amount % min_amount == 0
        bundles[min_amount] = requested_amount / min_amount
        break
      end

      multiples[min_amount].each do |multiple|
        if combined_multiples.include?(requested_amount - multiple)
          requested_amount -= multiple
          bundles[min_amount] = multiple / min_amount
          break
        end
      end
    end

    bundles
  end

  def multiples(requested_amount, min_amounts)
    multiples = {}

    min_amounts.sort.reverse.each do |min_amount|
      multiples[min_amount] = []

      (1..requested_amount).each { |n| multiples[min_amount] << n if n % min_amount == 0 }

      multiples[min_amount] = multiples[min_amount].sort.reverse
    end

    multiples
  end
end