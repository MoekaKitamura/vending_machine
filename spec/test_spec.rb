require_relative '../machine/vending_drink'

RSpec.describe VendingMachineOriginal do
  let(:origin) {DrinkVendingMachine.new}
  describe "slot_money 機能" do
    context "slot_money に 100 円を入れたとき" do
      it "@slot_money が100 円増える" do
        origin.slot_money(100)
        expect(origin.current_slot_money).to eq 100
      end
    end
    context "slot_moneyに101 円入れたとき" do
      it "@slot_money は変わらない" do
        origin.slot_money(1)
        expect(origin.current_slot_money).to eq 0
      end
    end
    context "100 円を入れたとき" do
      it "画面に水のみ表示される" do
        test_origin = origin
        expect{test_origin.slot_money(100)}.to output("[\"water\"]が買えます\n").to_stdout
      end
    end
  end
  describe "current_slot_money 機能" do
    context "current_slot_money メソッドを実行したとき" do
      it "@slot_money が返る" do
        expect(origin.current_slot_money).to eq 0
      end
    end
  end
  describe "sales 機能" do
    context "sales メソッドを実行したとき" do
      it "@sales_money が返る" do
        expect(0).to eq origin.sales
      end
    end
  end
  describe "return_money 機能" do
    context "return_money メソッドを実行したとき" do
      it "@slot_money 0 になる" do
        test_origin = origin
        test_origin.slot_money(100)
        test_origin.return_money
        expect(0).to eq test_origin.current_slot_money
      end
    end
  end
  describe "item_charge 機能" do
    context "item_charge メソッドを実行したとき" do
      it "引数の在庫が補充される" do
        test_origin = origin
        test_origin.slot_money(1000)
        test_origin.item_charge("coke")
        5.times {test_origin.buy("coke")}
        expect{ test_origin.buyable_list}.to output("[\"coke\", \"redbull\", \"water\"]が買えます\n").to_stdout
        
      end
    end
    context "間違えた商品を補充しようとしたとき" do
      it "補充出来ない" do
        test_origin = origin
        expect{ test_origin.item_charge("cok")}.to output("正しい商品をいれて下さい\n").to_stdout
      end
    end
  end
  describe "item_discard 機能" do
    context "item_discard メソッドを実行したとき" do
      it "引数の在庫が廃棄される" do
        test_origin = origin
        test_origin.slot_money(1000)
        5.times { test_origin.item_discard("coke")}
        expect{ test_origin.buy("coke")}.to output("在庫がありません\n").to_stdout
      end
    end
    context "間違えた商品を廃棄しようとしたとき" do
      it "廃棄出来ない" do
        test_origin = origin
        expect{ test_origin.item_discard("cok")}.to output("正しい商品を選んで下さい\n").to_stdout
      end
    end
  end
end