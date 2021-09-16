require "./machine/vm_original"
require "./machine/special_buy_system_module"
require "./machine/item"

class IceCreamVendingMachine < VendingMachineOriginal
  def initialize
    super
    @product = IceCream.new
    info_ice_cream
  end

  def info_ice_cream
    puts "＼こちらの中からお選びください！！🍦／"
    puts "#{@product.chocolate[:name]}は#{@product.chocolate[:price]}円です"
    puts "#{@product.strawberry[:name]}は#{@product.strawberry[:price]}円です"
    puts "#{@product.green_tea[:name]}は#{@product.green_tea[:price]}円です"
    puts "#{@product.cookie_cream[:name]}は#{@product.cookie_cream[:price]}円です"
    puts "#{@product.chocolate_mint[:name]}は#{@product.chocolate_mint[:price]}円です"
  end

  def buyable_list
    @lists = []
    @lists << "chocolate" if @slot_money >= @product.chocolate[:price] && @product.chocolate[:stock] > 0
    @lists << "strawberry" if @slot_money >= @product.strawberry[:price] && @product.strawberry[:stock] > 0
    @lists << "green_tea" if @slot_money >= @product.green_tea[:price] && @product.green_tea[:stock] > 0
    @lists << "cookie_cream" if @slot_money >= @product.cookie_cream[:price] && @product.cookie_cream[:stock] > 0
    @lists << "chocolate_mint" if @slot_money >= @product.chocolate_mint[:price] && @product.chocolate_mint[:stock] > 0
    if @lists.empty?
      puts "買えるものはありません"
    else
      puts "#{@lists}が買えます"
    end
  end

  def buyable?(ice_cream)
    begin
      ice_cream_choice = @product.send(ice_cream)
      if @slot_money >= ice_cream_choice[:price] && ice_cream_choice[:stock] > 0
        puts "あなたは#{ice_cream_choice[:name]}が買えます！！！今すぐ食べましょう！！XD"
      else 
        puts "ごめんなさい、#{ice_cream_choice[:name]}は買えません・・・X("
        buyable_list
      end
    rescue
      puts "そんな商品はありません！！！"
    end
  end
end
