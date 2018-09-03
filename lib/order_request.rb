class OrderRequest
  attr_reader :min_amount, :code

  def initialize(min_amount, code)
    raise StandardError if min_amount.nil? || min_amount.class != Fixnum
    raise StandardError if code.nil? || code.class != String

    @min_amount = min_amount
    @code = code
  end

  def self.parse(input)
    begin
      params = input.split(' ')
      OrderRequest.new(Integer(params[0]), String(params[1]))
    rescue StandardError
      raise StandardError, "Invalid input: #{input}"
    end
  end
end