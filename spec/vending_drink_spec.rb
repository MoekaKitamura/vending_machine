require_relative '../machine/vending_drink'

RSpec.describe DrinkVendingMachine do 
  let(:vm){DrinkVendingMachine.new}
  describe "info_drink 機能" do
    context "インスタンス化した時点で、初期値で" do
      it "自販機で販売しているラインナップが出力される" do
        expect{vm}.to output("＼こちらの中からお選びください！！🥤／\ncokeは120円です\nwaterは100円です\nredbullは200円です\n").to_stdout
      end
    end
  end
  describe "buyable_list 機能" do
    context "お金を100円入れた時" do
      it "水が買える" do
        vm.slot_money(100)
        expect{vm.buyable_list}.to output("[\"water\"]が買えます\n").to_stdout
      end
    end
    context "お金を200円入れた時" do
      it "全ての商品が買える" do
        2.times {vm.slot_money(100)}
        expect{vm.buyable_list}.to output("[\"coke\", \"redbull\", \"water\"]が買えます\n").to_stdout
      end
    end
    context "コーラの在庫が無くなった時" do
      it "コーラが買えない" do
        2.times {vm.slot_money(100)}
        5.times {vm.item_discard('coke')}
        expect{vm.buyable_list}.to output("[\"redbull\", \"water\"]が買えます\n").to_stdout
      end
    end
  end
  describe "buyable? 機能" do
    context "お金も在庫も十分な時" do
      it "コーラが買える" do
        vm.slot_money(1000)
        expect{vm.buyable?('coke')}.to output("あなたはcokeが買えます！！！今すぐ飲みましょう！！XD\n").to_stdout
      end
    end
    context "お金が不十分な時" do
      it "コーラが買えない" do
        vm.slot_money(100)
        expect{vm.buyable?('coke')}.to output("ごめんなさい、cokeは買えません・・・X(\n[\"water\"]が買えます\n").to_stdout
      end
    end
    context "在庫が不十分な時" do
      it "コーラが買えない" do
        vm.slot_money(1000)
        5.times {vm.item_discard('coke')}
        expect{vm.buyable?('coke')}.to output("ごめんなさい、cokeは買えません・・・X(\n[\"redbull\", \"water\"]が買えます\n").to_stdout
      end
    end
    context "間違った商品を買おうとした時" do
      it "商品がないことを知らせる" do
        vm.slot_money(1000)
        expect{vm.buyable?('cok')}.to output("そんな商品はありません！！！\n").to_stdout
      end
    end
  end
end