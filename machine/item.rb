class Drink
  attr_accessor :coke, :redbull, :water
  def initialize
    @coke = {price:120, name:'coke', stock: 5}
    @redbull = {price:200, name:'redbull', stock: 5}
    @water = {price:100, name:'water', stock: 5}
  end
end

class IceCream
  attr_accessor :chocolate, :strawberry, :green_tea, :cookie_cream, :chocolate_mint
  def initialize
    @chocolate = {price:300, name:'chocolate', stock:10}
    @strawberry = {price:350, name:'strawberry', stock:5}
    @green_tea = {price:500, name:'green_tea', stock:1}
    @cookie_cream = {price: 400, name: "cookie&cream", stock: 4}
    @chocolate_mint = {price: 300, name: "chocolate&mint", stock: 5}
  end
end

class Item
  attr_accessor :name, :price

  def initialize(name, price)
    #...
  end
end

class StockItem
  attr_accessor :item, :stock

  def initialize(item, stock)
    @item = item
    @stock = stock
  end

  def up
    @stock += 1
  end
end



