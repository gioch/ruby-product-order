class Order
  attr_accessor :items

  def initialize
    @items = {}
  end

  def add_item(product_code, total_pack_count, min_pack_amount, pack_price)
    items[product_code] = [] if items[product_code].nil?
    items[product_code] << {
      total_pack_count: total_pack_count,
      min_pack_amount: min_pack_amount,
      pack_price: pack_price,
    }
  end

  def total_price(product_code)
    items[product_code].inject(0) do |sum, i|
      sum + (i[:pack_price] * i[:total_pack_count])
    end
  end

  def total_pack_amount(product_code)
    items[product_code].inject(0) do |sum, i|
      sum + (i[:total_pack_count] * i[:min_pack_amount])
    end
  end

  def to_s
    str = ""
    items.keys.each do |code|
      str += "#{total_pack_amount(code)} #{code} $#{total_price(code)} \n"
      items[code].sort_by { |i| i[:min_pack_amount] }.each do |i|
        str += " - "
        str += "#{i[:total_pack_count]} x #{i[:min_pack_amount]} $#{i[:pack_price]} \n"
      end
    end

    str
  end

  def ==(other)
    to_s == other.to_s
  end
end