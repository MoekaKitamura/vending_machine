module SpecialBuySystem
  @previous = nil
  @flag = []
  def buy(item)
    begin
      # send ๅฐ็จ
      # item_choice = @product.send(item)
      # to_sym_vm ๅฐ็จ
      item_choice = @product[item.to_sym]
      if @slot_money >= item_choice[:price] && item_choice[:stock] > 0
        if @previous == item
          @flag << item
          if @flag.length >= 2 
            puts "๐#{item}#{@flag.length + 1}้ฃ็ถ!!!๐"
          end
        else
          @flag = []
        end
        item_choice[:stock] -= 1
        @sales_money += item_choice[:price]
        @slot_money -= item_choice[:price]
        puts "#{item_choice[:name]}ใฎใ่ฒทใไธใใใใใจใใใใใพใ๏ผ๏ผ"
        @previous = item
        puts"ๆฎ้#{@slot_money}ๅ"
        buyable_list
      else
        if @slot_money < item_choice[:price]
          puts "ใ้ใ่ถณใใพใใ"
        elsif item_choice[:stock] = 0
          puts "ๅจๅบซใใใใพใใ"
        end
      end
    rescue
      puts "๐ฃใใใชๅๅใฏใใใพใใใใใใงใ้ฃฒใฟใช๏ผ๏ผ๐"
      # send ๅฐ็จ
      # rand_choice = @product.send(@lists.sample)
      # to_sym_vm ๅฐ็จ
      rand_choice = @product[@lists.sample.to_sym]
      rand_choice[:stock] -= 1
      @sales_money += rand_choice[:price]
      @slot_money -= rand_choice[:price]
      puts "#{rand_choice[:name]}ใฎใ่ฒทใไธใใใใใจใใใใใพใ๏ผ๏ผ"
    end
  end
end
