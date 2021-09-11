
# require '/Users/kitamuramoeka/workspace/vending_machine/vm_moeka.rb'  pwdでパスを確認できる

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
end

class VendingMachine < VendingMachineOriginal
  
  def initialize
    super
    @drink = Drink.new
    @previousdrink = nil
    @flug = []
    info
  end
  
  def drink_charge(drink)
    begin
      charge_drink = @drink.send(drink)
      charge_drink[:stock] += 1
    rescue
      puts "正しい商品をいれて下さい"
    end
  end

  def drink_discard(drink)
    begin
      discard_drink = @drink.send(drink)
      discard_drink[:stock] -= 1
    rescue
      puts "正しい商品を選んで下さい"
    end
  end

  def info
    puts "＼こちらの中からお選びください！！🥤／"
    puts "#{@drink.coke[:name]}は#{@drink.coke[:price]}円です"
    puts "#{@drink.water[:name]}は#{@drink.water[:price]}円です"
    puts "#{@drink.redbull[:name]}は#{@drink.redbull[:price]}円です"
  end

  def buy(drink)
    begin
      drink_choice = @drink.send(drink)
      if @slot_money >= drink_choice[:price] && drink_choice[:stock] > 0
        if @previousdrink == drink
          @flug << drink
          if @flug.length == 2
            puts "🎊#{drink}3連続!!!🎊"
            @flug = []
          end
        else
          @flug = []
        end
        
        drink_choice[:stock]-=1
        @sales_money += drink_choice[:price]
        @slot_money -= drink_choice[:price]
        puts "#{drink_choice[:name]}のお買い上げありがとうございます！！"
        @previousdrink = drink

        puts"残金#{@slot_money}円"
        buyable_list
      else
        if @slot_money < drink_choice[:price]
          puts "お金が足りません"
        elsif drink_choice[:stock] = 0
          puts "在庫がありません"
        end
      end
    rescue
        puts "💣そんな商品はありません。これでも飲みな！！😁"
        rand_choice = @drink.send(@lists.sample)
        rand_choice[:stock]-=1
        @sales_money += rand_choice[:price]
        @slot_money -= rand_choice[:price]
        puts "#{rand_choice[:name]}のお買い上げありがとうございます！！"
    end
    
  end

  def buyable?(drink)
    drink_choice = @drink.send(drink)
    if @slot_money >= drink_choice[:price] && drink_choice[:stock] > 0
      puts "あなたは#{drink_choice[:name]}が買えます！！！今すぐ飲みましょう！！XD"
    else 
      puts "ごめんなさい、#{drink_choice[:name]}は買えません・・・X("
      buyable_list
    end
  end

  def buyable_list
    @lists = []
    @lists << "coke" if @slot_money >= @drink.coke[:price] && @drink.coke[:stock] > 0
    @lists << "redbull" if @slot_money >= @drink.redbull[:price] && @drink.redbull[:stock] > 0
    @lists << "water" if @slot_money >= @drink.water[:price] && @drink.water[:stock] > 0
    if @lists.empty?
      puts "買えるものはありません"
    else
      puts "#{@lists}が買えます"
    end
  end
  
end

class Drink
  attr_accessor :coke, :redbull, :water
  def initialize
    @coke = {price:120, name:'coke', stock: 5}
    @redbull = {price:200, name:'redbull', stock: 5}
    @water = {price:100, name:'water', stock: 5}
  end
end

# 間違えたものを入力したら適当なもの買わされる。
# company = VendingMachineOriginal.new
# vm = VendingMachine.new
# puts "-----------------------------------"
# vm.slot_money(100)
# vm.slot_money(100)
# puts "-----------------------------------"
# p vm
# puts "-----------------------------------"
# vm.buy("cok")
# p vm

# 3回連続同じものを買うと祝われる。
# company = VendingMachineOriginal.new
# vm = VendingMachine.new
# puts "-----------------------------------"
# vm.slot_money(100)
# vm.slot_money(100)
# vm.slot_money(100)
# vm.slot_money(100)
# puts "-----------------------------------"
# vm.buy("coke")
# vm.buy("coke")
# vm.buy("coke")

# 買えない理由表示(在庫なしver)
# company = VendingMachineOriginal.new
# vm = VendingMachine.new
# puts "-----------------------------------"
# vm.slot_money(100)
# vm.slot_money(100)
# vm.slot_money(100)
# vm.slot_money(100)
# vm.drink_discard("water")
# vm.drink_discard("water")
# vm.drink_discard("water")
# vm.drink_discard("water")
# vm.drink_discard("water")
# p vm
# puts "-----------------------------------"
# vm.buyable_list
# vm.buy("water")

# 買えない理由表示(お金なしver)
# company = VendingMachineOriginal.new
# vm = VendingMachine.new
# puts "-----------------------------------"
# vm.slot_money(100)
# p vm
# puts "-----------------------------------"
# vm.buyable_list
# vm.buy("redbull")

