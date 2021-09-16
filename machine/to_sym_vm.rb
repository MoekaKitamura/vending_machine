require "./machine/vm_original"
require "./machine/special_buy_system_module"
require "./machine/item"

class DrinkVendingMachine < VendingMachineOriginal
  # include SpecialBuySystem
  def initialize
    super
    @products = Drink.new
    info_drink
  end

  def info_drink
    puts "＼こちらの中からお選びください！！🥤／"
    @product = {coke: @products.coke, water: @products.water, redbull: @products.redbull}
    puts "#{@product[:coke][:name]}は#{@product[:coke][:price]}円です"
    puts "#{@product[:water][:name]}は#{@product[:water][:price]}円です"
    puts "#{@product[:redbull][:name]}は#{@product[:redbull][:price]}円です"
  end

  def buyable_list
    @lists = []
    @lists << "coke" if @slot_money >= @product[:coke][:price] && @product[:coke][:stock] > 0
    @lists << "redbull" if @slot_money >= @product[:redbull][:price] && @product[:redbull][:stock] > 0
    @lists << "water" if @slot_money >= @product[:water][:price] && @product[:water][:stock] > 0
    if @lists.empty?
      puts "買えるものはありません"
    else
      puts "#{@lists}が買えます"
    end
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
end