class Vendor
  
  attr_reader :name,
              :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    return 0 if !@inventory.keys.include?(item)
    @inventory[item]
  end

  def stock(item, quantity)
    @inventory[item] += quantity
  end
end
