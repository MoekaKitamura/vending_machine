module SpecialBuySystem
  @previous = nil
  @flag = []
  def buy(item)
    begin
      # send 専用
      item_choice = @product.send(item)
      # to_sym_vm 専用
      # item_choice = @product[item.to_sym]
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
      # send 専用
      rand_choice = @product.send(@lists.sample)
      # to_sym_vm 専用
      # rand_choice = @product[@lists.sample.to_sym]
      rand_choice[:stock] -= 1
      @sales_money += rand_choice[:price]
      @slot_money -= rand_choice[:price]
      puts "#{rand_choice[:name]}のお買い上げありがとうございます！！"
    end
  end
end
