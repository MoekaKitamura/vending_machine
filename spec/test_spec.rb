require_relative '../vending/test'

RSpec.describe Calculate do
  it '1000の半分は500になる' do
    calculate = Calculate.new(1000)
    expect(calculate.half_num).to eq 500
  end
end