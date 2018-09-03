class Product
  InvalidProductPack = Class.new(StandardError)
  DuplicateProductPack = Class.new(StandardError)

  attr_reader :name, :code
  attr_accessor :packs

  def initialize(name, code)
    @name = name
    @code = code
    @packs = []
  end

  def add_product_pack(product_pack)
    raise(InvalidProductPack, product_pack) unless product_pack.instance_of?(ProductPack)
    raise(DuplicateProductPack, "Similar pack already exists") if
      pack_exists?(product_pack)

    packs << product_pack
  end

  def pack_min_amounts
    packs.map(&:min_amount)
  end

  private

  def pack_exists?(pack)
    packs.select{ |e| e.min_amount == pack.min_amount && e.price == pack.price }.any?
  end
end