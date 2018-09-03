class ProductPack
  attr_reader :min_amount, :price

  def initialize(min_amount, price)
    raise StandardError if min_amount.nil? || min_amount.class != Fixnum
    raise StandardError if price.nil? || ![Float, Fixnum].include?(price.class)

    @min_amount = min_amount
    @price = price
  end
end