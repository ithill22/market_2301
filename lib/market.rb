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
      if vendor.check_stock(item) > 0
        in_stock << vendor
      end
    end
    in_stock
  end
  
end
