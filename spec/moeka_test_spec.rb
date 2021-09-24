# require_relative '../vending/test'
require_relative '../machine/vending_drink'
require_relative '../machine/vm_original'
require_relative '../machine/item'


# bundle exec rspec spec/moeka_test_spec.rb

RSpec.describe DrinkVendingMachine do
  let(:vm){DrinkVendingMachine.new}
  describe 'buy機能' do
    context '在庫とお金がある場合' do
      it 'Cokeが買える' do
        vm.slot_money(1000)
        vm.buy("coke")
        expect(vm.sales).to eq 120
        expect(vm.current_slot_money).to eq 880
      end
    end
    context '在庫がない場合' do
      it 'Cokeが買えない' do
        vm.slot_money(1000)
        5.times {vm.item_discard("coke")}
        vm.buy("coke")
        expect(vm.sales).not_to eq 120
        expect(vm.current_slot_money).to eq 1000
      end
    end
    context 'お金がない場合' do
      it 'Cokeが買えない' do
        vm.buy("coke")
        expect(vm.sales).to eq 0
      end
    end
    context '存在しない商品を買おうとしたとき' do
      it 'Cokeが買えない' do
        vm.slot_money(1000)
        vm.buy("cok")
        expect(vm.sales).to eq 0
        expect(vm.current_slot_money).to eq 1000
      end
    end
  end

  describe '#info_drink' do
    context 'インスタンス化した時点で、初期値で' do
      it '自販機で販売しているラインナップが出力される' do
      expect{vm}.to output("＼こちらの中からお選びください！！🥤／\ncokeは120円です\nwaterは100円です\nredbullは200円です\n").to_stdout
      end
    end
  describe 'Drinkクラス' do
    let(:product){Drink.new}
    context 'Drinkクラスをインスタンス化する' do
      it '名前、金額、在庫の情報を持ったcokeのインスタンスができる' do
        expect(product.coke[:name]).to eq "coke"
        expect(product.coke[:price]).to eq 120
        expect(product.coke[:stock]).to eq 5
      end
      it '名前、金額、在庫の情報を持ったwaterのインスタンスができる' do
        expect(product.water[:name]).to eq "water"
        expect(product.water[:price]).to eq 100
        expect(product.water[:stock]).to eq 5
      end
      it '名前、金額、在庫の情報を持ったredbullのインスタンスができる' do
        expect(product.redbull[:name]).to eq "redbull"
        expect(product.redbull[:price]).to eq 200
        expect(product.redbull[:stock]).to eq 5
      end
    end
  end
end