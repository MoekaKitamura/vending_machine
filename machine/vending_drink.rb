require "./machine/vm_original"
require "./machine/special_buy_system_module"
require "./machine/item"

class DrinkVendingMachine < VendingMachineOriginal
  # include SpecialBuySystem
  def initialize
    super
    @products = Drink.new
    info_drink

    # Item、Stockクラスの初期化例
    items = [
      Item.new('coke', 120),
      Item.new('water', 120),
      Item.new('redbull', 120),
    ]

    @stocks = items.map{ |item| StockItem.new(item, 5) }
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
    puts "買えるものはありません" if @lists.empty?
    puts "#{@lists}が買えます" unless @lists.empty?

    @lists
  end

  def buyable_message(name)
    "あなたは#{name}が買えます！！！今すぐ飲みましょう！！XD"
  end
end
