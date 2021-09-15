module SpecialBuySystem
  def buy(item)
    begin
      item_choice = @product.send(item)
      if @slot_money >= item_choice[:price] && item_choice[:stock] > 0
        if @previous == item
          @flag << item
          if @flag.length >= 2 
            puts "🎊#{item}#{@flag.length + 1}連続!!!🎊"
          end
        else
          @flag = []
        end
        item_choice[:stock] -= 1
        @sales_money += item_choice[:price]
        @slot_money -= item_choice[:price]
        puts "#{item_choice[:name]}のお買い上げありがとうございます！！"
        @previous = item
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
      puts "💣そんな商品はありません。これでも飲みな！！😁"
      rand_choice = @product.send(@lists.sample)
      rand_choice[:stock] -= 1
      @sales_money += rand_choice[:price]
      @slot_money -= rand_choice[:price]
      puts "#{rand_choice[:name]}のお買い上げありがとうございます！！"
    end
  end
end
