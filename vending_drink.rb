
# require '/Users/kitamuramoeka/workspace/vending_machine/vm_moeka.rb'  pwdでパスを確認できる

require "./vm_original"
require "./special_buy_system_module"
require "./item"

class DrinkVendingMachine < VendingMachineOriginal
  include SpecialBuySystem
  def initialize
    super
    @previous = nil
    @flag = []
    @product = Drink.new
    info_drink
  end
  
  def info_drink
    puts "＼こちらの中からお選びください！！🥤／"
    puts "#{@product.coke[:name]}は#{@product.coke[:price]}円です"
    puts "#{@product.water[:name]}は#{@product.water[:price]}円です"
    puts "#{@product.redbull[:name]}は#{@product.redbull[:price]}円です"
  end

  def buyable_list
    @lists = []
    @lists << "coke" if @slot_money >= @product.coke[:price] && @product.coke[:stock] > 0
    @lists << "redbull" if @slot_money >= @product.redbull[:price] && @product.redbull[:stock] > 0
    @lists << "water" if @slot_money >= @product.water[:price] && @product.water[:stock] > 0
    if @lists.empty?
      puts "買えるものはありません"
    else
      puts "#{@lists}が買えます"
    end
  end

  def buyable?(drink)
    begin
      drink_choice = @product.send(drink)
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
end



# 間違えたものを入力したら適当なもの買わされる。
# vm = DrinkVendingMachine.new
# puts "-----------------------------------"
# vm.slot_money(100)
# vm.slot_money(100)
# puts "-----------------------------------"
# p vm
# puts "-----------------------------------"
# vm.buy("cok")
# p vm

# 3回連続同じものを買うと祝われる。
# vm = DrinkVendingMachine.new
# puts "-----------------------------------"
# vm.slot_money(100)
# vm.slot_money(100)
# vm.slot_money(100)
# vm.slot_money(100)
# vm.slot_money(100)
# vm.slot_money(100)
# vm.slot_money(100)
# vm.slot_money(100)
# vm.slot_money(100)
# vm.slot_money(100)
# vm.slot_money(100)
# vm.slot_money(100)
# vm.slot_money(100)
# vm.slot_money(100)
# vm.item_charge("coke")
# vm.item_charge("coke")
# vm.item_charge("coke")
# vm.item_charge("coke")
# vm.item_charge("coke")
# vm.item_charge("coke")
# vm.item_charge("coke")
# puts "-----------------------------------"
# vm.buy("coke")
# vm.buy("coke")
# vm.buy("coke")
# vm.buy("coke")
# vm.buy("coke")
# vm.buy("water")
# vm.buy("coke")
# vm.buy("coke")
# vm.buy("coke")
# vm.buy("coke")
# vm.buy("coke")

# 買えない理由表示(在庫なしver)
# vm = DrinkVendingMachine.new
# puts "-----------------------------------"
# vm.slot_money(100)
# vm.slot_money(100)
# vm.slot_money(100)
# vm.slot_money(100)
# vm.item_discard("water")
# vm.item_discard("water")
# vm.item_discard("water")
# vm.item_discard("water")
# vm.item_discard("water")
# p vm
# puts "-----------------------------------"
# vm.buyable_list
# vm.buy("water")

# 買えない理由表示(お金なしver)
# vm = DrinkVendingMachine.new
# puts "-----------------------------------"
# vm.slot_money(100)
# p vm
# puts "-----------------------------------"
# vm.buyable_list
# vm.buy("redbull")

