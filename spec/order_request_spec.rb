require 'order_request'

describe OrderRequest do
  describe '.parse' do
   it 'should return an error for not correct input format' do
     expect { described_class.parse('A CFF') }.to raise_exception(StandardError, 'Invalid input: A CFF')
     expect { described_class.parse('14cff') }.to raise_exception(StandardError, 'Invalid input: 14cff')
     expect { described_class.parse('caf14') }.to raise_exception(StandardError, 'Invalid input: caf14')
   end

   it 'should return a valid minimum amount for valid input' do
     expect(described_class.parse('14 ACF').min_amount).to eq(14)
   end

   it 'should return a valid product code for valid input' do
     expect(described_class.parse('10 ACF').code).to eq('ACF')
   end
  end
end