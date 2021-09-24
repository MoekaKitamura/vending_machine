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
      it "@slot_money が 0 になる" do
        origin.slot_money(100)
        origin.return_money
        expect(0).to eq origin.current_slot_money
      end
    end
  end
  describe "item_charge 機能" do
    context "item_charge メソッドを実行したとき" do
      it "引数の在庫が補充される" do
        origin.slot_money(1000)
        origin.item_charge("coke")
        5.times {origin.buy("coke")}
        expect{ origin.buyable_list}.to output("[\"coke\", \"redbull\", \"water\"]が買えます\n").to_stdout
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
        origin.slot_money(1000)
        5.times { origin.item_discard("coke")}
        expect{ origin.buy("coke")}.to output("在庫がありません\n").to_stdout
      end
    end
    context "間違えた商品を廃棄しようとしたとき" do
      it "廃棄出来ない" do
        test_origin = origin
        expect{ test_origin.item_discard("cok")}.to output("正しい商品を選んで下さい\n").to_stdout
      end
    end
  end
  describe "buy 機能" do
    context "在庫とお金がある場合" do
      it "Cokeが買える" do
        origin.slot_money(1000)
        origin.buy("coke")
        expect(origin.sales).to eq 120
        expect(origin.current_slot_money).to eq 880
      end
    end
    context "在庫がない場合" do
      it "Cokeが買えない" do
        origin.slot_money(1000)
        5.times {origin.item_discard("coke")}
        origin.buy("coke")
        expect(origin.sales).not_to eq 120
        expect(origin.current_slot_money).to eq 1000
      end
    end
    context "お金がない場合" do
      it "Cokeが買えない" do
        origin.buy("coke")
        expect(origin.sales).to eq 0
      end
    end
    context "存在しない商品を買おうとしたとき" do
      it "Cokeが買えない" do
        origin.slot_money(1000)
        origin.buy("cok")
        expect(origin.sales).to eq 0
        expect(origin.current_slot_money).to eq 1000
      end
    end
  end
end



