class Market

  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    names = []
    @vendors.each do |vendor|
      names << vendor.name
    end
    names
  end

  def vendors_that_sell(item)
    in_stock = []
    @vendors.each do |vendor|
      if vendor.inventory.include?(item)
        in_stock << vendor
      end
    end
    in_stock
  end

  def sorted_item_list(vendor)
    list_of_items = []
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        if quantity > 0
          list_of_items << item.name
        end
      end
    end
    list_of_items.uniq.sort
  end

  def total_inventory
    total_inventory = Hash.new{|h, k| h[k] = {quantity: 0, vendors: []}}
    @vendors.map do |vendor|
      vendor.inventory.each do |item, quantity|
        if !total_inventory.key?(item)
          total_inventory[item]
          @vendors.each do |vendor|
            total_inventory[item][:quantity] += vendor.check_stock(item)
          end
        else
        end
        total_inventory[item][:vendors] = vendors_that_sell(item)
      end
    end
    total_inventory
  end

  # def overstocked_items
  #   overstocked = []
  #   @vendors.each do |vendor|
  #     vendor.inventory do |item, quantity|
  #       if quantity > 50 && 
  #         overstocked << item
  #       end
  #     end
  #   end
  #   overstocked
  # end
  
end
