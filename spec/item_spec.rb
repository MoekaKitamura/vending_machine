require_relative '../machine/item'
RSpec.describe Drink do
  describe "Drinkクラス" do
    let(:product){Drink.new}
    context "Drinkクラスをインスタンス化する" do
      it '名前、金額、在庫の情報を持ったcokeのインスタンスができる' do
        expect(product.coke[:name]).to eq "coke"
        expect(product.coke[:price]).to eq 120
        expect(product.coke[:stock]).to eq 5
      end
      it "名前、金額、在庫の情報を持ったwaterのインスタンスができる" do
        expect(product.water[:name]).to eq "water"
        expect(product.water[:price]).to eq 100
        expect(product.water[:stock]).to eq 5
      end
      it "名前、金額、在庫の情報を持ったredbullのインスタンスができる" do
        expect(product.redbull[:name]).to eq "redbull"
        expect(product.redbull[:price]).to eq 200
        expect(product.redbull[:stock]).to eq 5
      end
    end
  end
end
