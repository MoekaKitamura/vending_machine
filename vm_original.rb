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
      charge_item = @product.send(item)
      charge_item[:stock] += 1
    rescue
      puts "正しい商品をいれて下さい"
    end
  end

  def item_discard(item)
    begin
      discard_item = @product.send(item)
      discard_item[:stock] -= 1
    rescue
      puts "正しい商品を選んで下さい"
    end
  end

  def buy(item)
    item_choice = @product.send(item)
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
  end
end
