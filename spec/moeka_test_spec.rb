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
RSpec.describe DrinkVendingMachine do 
  let(:vm){DrinkVendingMachine.new}
  describe "#buyable_list" do
    context 'お金を100円入れた時' do
      it '水が買える' do
        vm.slot_money(100)
        expect{vm.buyable_list}.to output("[\"water\"]が買えます\n").to_stdout
      end
    end
    context 'お金を200円入れた時' do
      it '全ての商品が買える' do
        2.times {vm.slot_money(100)}
        expect{vm.buyable_list}.to output("[\"coke\", \"redbull\", \"water\"]が買えます\n").to_stdout
      end
    end
    context 'コーラの在庫が無くなった時' do
      it 'コーラが買えない' do
        2.times {vm.slot_money(100)}
        5.times {vm.item_discard('coke')}
        expect{vm.buyable_list}.to output("[\"redbull\", \"water\"]が買えます\n").to_stdout
      end
    end
  end
  describe "#buyable?(drink)" do
    context 'お金も在庫も十分な時' do
      it 'コーラが買える' do
        vm.slot_money(1000)
        expect{vm.buyable?('coke')}.to output("あなたはcokeが買えます！！！今すぐ飲みましょう！！XD\n").to_stdout
      end
    end
    context 'お金が不十分な時' do
      it 'コーラが買えない' do
        vm.slot_money(100)
        expect{vm.buyable?('coke')}.to output("ごめんなさい、cokeは買えません・・・X(\n[\"water\"]が買えます\n").to_stdout
      end
    end
    context '在庫が不十分な時' do
      it 'コーラが買えない' do
        vm.slot_money(1000)
        5.times {vm.item_discard('coke')}
        expect{vm.buyable?('coke')}.to output("ごめんなさい、cokeは買えません・・・X(\n[\"redbull\", \"water\"]が買えます\n").to_stdout
      end
    end
    context '間違った商品を買おうとした時' do
      it '商品がないことを知らせる' do
        vm.slot_money(1000)
        expect{vm.buyable?('cok')}.to output("そんな商品はありません！！！\n").to_stdout
      end
    end
  end
end
def buyable_list
  @lists = []
  @lists << "coke" if @slot_money >= @product[:coke][:price] && @product[:coke][:stock] > 0
  @lists << "redbull" if @slot_money >= @product[:redbull][:price] && @product[:redbull][:stock] > 0
  @lists << "water" if @slot_money >= @product[:water][:price] && @product[:water][:stock] > 0
  puts "買えるものはありません" if @lists.empty?
  puts "#{@lists}が買えます" unless @lists.empty?
end