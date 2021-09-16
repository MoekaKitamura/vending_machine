require "./machine/vending_ice_cream"

puts "----------------------------------------------"
puts "[インフォメーション]"
puts "----------------------------------------------"
vm = IceCreamVendingMachine.new
puts "----------------------------------------------"
puts "[お金を入れる]" 
puts "----------------------------------------------"
vm.slot_money(1000)
vm.slot_money(1000)
puts "----------------------------------------------"
puts "[ストロベリーアイスを5本買う]"
puts "----------------------------------------------"
vm.buy("strawberry")
vm.buy("strawberry")
vm.buy("strawberry")
vm.buy("strawberry")
vm.buy("strawberry")
puts "----------------------------------------------"
puts "[存在しない商品を買おうとしたとき]"
puts "----------------------------------------------"
vm.buy("strofsky")
puts "----------------------------------------------"
puts "[ストロベリーアイスを補充する その後購入しようとする]"
puts "----------------------------------------------"
vm.item_charge("strawberry")
vm.buy("strawberry")
puts "----------------------------------------------"
puts "[チョコレートミントアイスを５本捨てる その後購入しようとする]"
puts "----------------------------------------------"
vm.item_discard("chocolate_mint")
vm.item_discard("chocolate_mint")
vm.item_discard("chocolate_mint")
vm.item_discard("chocolate_mint")
vm.item_discard("chocolate_mint")
vm.buy("chocolate_mint")
puts "----------------------------------------------"
puts "[現時点の売上を照会する]"
puts "----------------------------------------------"
puts vm.sales
puts "----------------------------------------------"
puts "[strawberry が買えるか照会する]"
puts "----------------------------------------------"
vm.buyable?("strawberry")
puts "----------------------------------------------"
puts "[strawberry を間違えて strofsky と照会したとき]"
puts "----------------------------------------------"
vm.buyable?("strofsky")
puts "----------------------------------------------"