class VendingMachineOriginal
  MONEY = [10, 50, 100, 500, 1000].freeze 
  def initialize
    @slot_money = 0
    @sales_money = 0
  end

  def sales
    @sales_money
  end

  def current_slot_money
    @slot_money 
  end

  def return_money
    puts @slot_money
    @slot_money = 0
  end

  def slot_money(money)
    return false unless MONEY.include?(money)
    @slot_money += money
    buyable_list
  end

  def item_charge(item)
    begin
      # send 専用
      # charge_item = @product.send(item)
      # to_sym_vm 専用
      charge_item = @product[item.to_sym]
      charge_item[:stock] += 1
    rescue
      puts "正しい商品をいれて下さい"
    end
  end

  def item_discard(item)
    begin
      # send 専用
      # discard_item = @product.send(item)
      # to_sym_vm 専用
      discard_item = @product[item.to_sym]
      discard_item[:stock] -= 1
    rescue
      puts "正しい商品を選んで下さい"
    end
  end

  def buy(item)
    begin
      # send 専用
      # item_choice = @product.send(item)
      # to_sym_vm 専用
      item_choice = @product[item.to_sym]
      if @slot_money >= item_choice[:price] && item_choice[:stock] > 0
        item_choice[:stock]-=1
        @sales_money += item_choice[:price]
        @slot_money -= item_choice[:price]
        puts "#{item_choice[:name]}のお買い上げありがとうございます！！"
        puts"残金#{@slot_money}円"
        buyable_list
      else
        if @slot_money < item_choice[:price]
          puts "お金が足りません"
        elsif item_choice[:stock] = 0
          puts "在庫がありません"
        end
      end
    rescue
      puts "そんな商品はありません！！！"
    end
  end

  def find_by_name(name)
    @stocks.find{ |stock| stock.item.name == name }
  end

  def buyable?(drink)
    begin
      drink_choice = @product[drink.to_sym]
      if @slot_money >= drink_choice[:price] && drink_choice[:stock] > 0
        puts "あなたは#{drink_choice[:name]}が買えます！！！今すぐ飲みましょう！！XD"
      else 
        puts "ごめんなさい、#{drink_choice[:name]}は買えません・・・X("
        buyable_list
      end
    rescue
      puts "そんな商品はありません！！！"
    end
  end

  
  # もしbuyable?の内容でリファクタリングするのであれば、
  # 以下のように
  # 「親クラスで定義したメソッドを呼び出し」
  # 「親クラスで定義したメソッドの結果によって、子クラス独自の表示処理を行う」
  # という形にできれば見通しが良くなる
  #
  # def buyable?(drink)
  #   aaa = parent_function(drink)

  #   if aaa.present?
  #     puts '子クラスの成功表示'
  #   else
  #     puts '子クラスのエラー表示'
  #   end
  # end
end
