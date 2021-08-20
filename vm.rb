# このコードをコピペしてrubyファイルに貼り付け、そのファイルをirbでrequireして実行しましょう。
# 例
# irb
# require '/Users/kitamuramoeka/workspace/vending_machine/vm.rb'  pwdでパスを確認できる
# （↑のパスは、自動販売機ファイルが入っているパスを指定する）
# 初期設定（自動販売機インスタンスを作成して、vmという変数に代入する）
# vm = VendingMachine.new
# 作成した自動販売機に100円を入れる
# vm.slot_money (100)
# 作成した自動販売機に入れたお金がいくらかを確認する（表示する）
# vm.current_slot_money
# 作成した自動販売機に入れたお金を返してもらう
# vm.return_money

class VendingMachineOriginal
  MONEY=[]
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @slot_money = 0
    # 使いたい変数は初めにinitializeに初期値を設定しないと使えない
    @sales_money = 0
  end

  def stock
    puts "在庫は..."
  end

  #exit投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    @slot_money #@がついてるとグローバル変数
  end
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money(money)
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return false unless MONEY.include?(money)
    # 自動販売機にお金を入れる
    @slot_money += money
  end
  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts @slot_money
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end

  # 今の売上金が見たいとき、(vm.sales)
  def sales
    @sales_money
  end


end

class VendingMachinedrink < VendingMachineOriginal
  #attr_accessor :drink
  # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コードorb
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY.push(0, 50, 100, 500, 1000)
  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize #initializeメソッドは自動で適用される！！！！！！引数を期待していないコンストラクタ
    #インスタンス化するたびに初期値に戻る
    super
    @drink = Drink.new
  end

  def stock
    @drink
  end

  
  def buy(drink)
    # case drink
    # when "coke"
    #   buy_drink = @drink.coke
    # when "redbull"
    #   buy_drink = @drink.redbull
    # when "water"
    #   buy_drink = @drink.water
    # end
    begin
      buy_drink = @drink.send(drink)
      if @slot_money >= buy_drink[:price] && buy_drink[:stock] > 0
        buy_drink[:stock]-=1
        @sales_money += buy_drink[:price]
        @slot_money -= buy_drink[:price]
        puts "お買い上げありがとうございます！！"
        @slot_money
      else
        false
      end
    rescue
      puts "ありません"
    end
  end
  def can_buy(drink)
    buy_drink = @drink.send(drink)
    if @slot_money >= buy_drink[:price] && buy_drink[:stock] > 0
      puts "買えます"
    else 
      puts "買えません"
    end
  end
  def list
    @list = []
    @list << "coke" if @slot_money >= @drink.coke[:price] && @drink.coke[:stock] > 0
    @list << "redbull" if @slot_money >= @drink.redbull[:price] && @drink.redbull[:stock] > 0
    @list << "water" if @slot_money >= @drink.water[:price] && @drink.water[:stock] > 0 
    @list
  end
  
end

class Drink
  attr_accessor :coke, :redbull, :water

  def initialize
    @coke = {price:120, name:'coke', stock:5}
    @redbull = {price:200, name:'redbull', stock:5}
    @water = {price:100, name:'water', stock:5}
  end
end
# vm=VendingMachineIceCream.new
class VendingMachineIceCream < VendingMachineOriginal
  MONEY.push(0, 50, 100, 500, 1000)
  def initialize
    super
    @icecream = IceCream.new
  end

  def stock
    super
    p @icecream
  end

  def buy(icecream)
    begin
      buy_icecream = @icecream.send(icecream)
      if @slot_money >= buy_icecream[:price] && buy_icecream[:stock] > 0
        buy_icecream[:stock]-=1
        @sales_money += buy_icecream[:price]
        @slot_money -= buy_icecream[:price]
        puts "お買い上げありがとうございます！！"
        @slot_money
      else
        false
      end
    rescue
      puts "ありません"
    end
  end
  def can_buy(icecream)
    buy_icecream = @icecream.send(icecream)
    if @slot_money >= buy_icecream[:price] && buy_icecream[:stock] > 0
      puts "買えます"
    else 
      puts "買えません"
    end
  end
  def list
    @list = []
    @list << "chocolate" if @slot_money >= @icecream.chocolate[:price] && @icecream.chocolate[:stock] > 0
    @list << "strawberry" if @slot_money >= @icecream.strawberry[:price] && @icecream.strawberry[:stock] > 0
    @list << "greentea" if @slot_money >= @icecream.greentea[:price] && @icecream.greentea[:stock] > 0 
    @list
  end


end

class IceCream
  attr_accessor :chocolate, :strawberry, :greentea

  def initialize
    @chocolate = {price:300, name:'chocolate', stock:10}
    @strawberry = {price:350, name:'strawberry', stock:5}
    @greentea = {price:500, name:'greentea', stock:1}
  end
end