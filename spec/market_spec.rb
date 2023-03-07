require 'spec_helper'

RSpec.describe Market do
  let(:item1) {Item.new({name: 'Peach', price: "$0.75"})}
  let(:item2) {Item.new({name: 'Tomato', price: '$0.50'})}
  let(:item3) {Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})}
  let(:item4) {Item.new({name: "Banana Nice Cream", price: "$4.25"})}
  let(:vendor1) {Vendor.new("Rocky Mountain Fresh")}
  let(:vendor2) {Vendor.new("Ba-Nom-a-Nom")}
  let(:vendor3) {Vendor.new("Palisade Peach Shack")}
  let(:market) {Market.new("South Pearl Street Farmers Market")}

  describe '#initialize' do
    it 'can initialize' do
      expect(market).to be_instance_of(Market)
      expect(market.name).to eq("South Pearl Street Farmers Market")
      expect(market.vendors).to eq([])
    end
  end

  describe '#add_vendor' do
    it 'can add a vendor to the vendors array' do
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expect(market.vendors).to eq([vendor1, vendor2, vendor3])
    end
  end

  describe '#vendor_names' do
    it 'can list the names of all the vendors in the vendors array' do
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expect(market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end
  end

  describe '#vendors_that_sell' do
    it 'can return a list of vendors with specified item in stock' do
      expect(market.vendors_that_sell(item1)).to eq([])

      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
      vendor1.stock(item1, 35) 
      vendor1.stock(item2, 7) 
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)  

      expect(market.vendors_that_sell(item1)).to eq([vendor1, vendor3])
      expect(market.vendors_that_sell(item4)).to eq([vendor2])
    end
  end

  describe '#sorted_item_list' do
    it 'can return a list of names of all items in vendor inventory in alphabetic order' do
      expect(market.sorted_item_list(vendor1)).to eq([])

      market.add_vendor(vendor1)
      vendor1.stock(item1, 35) 
      vendor1.stock(item2, 7)
      vendor1.stock(item3, 25)
      vendor1.stock(item4, 50)

      expect(market.sorted_item_list(vendor1)).to eq(["Banana Nice Cream", 'Peach', "Peach-Raspberry Nice Cream", 'Tomato'])
    end
  end

  describe '#total_inventory' do
    it 'can return a hash with items as keys and a subhash with quantity(key)/total inventory(value) and vendors(key)/array of vendors with item(value).' do
      expect(market.total_inventory).to eq({})

      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
      vendor1.stock(item1, 35) 
      vendor1.stock(item2, 7) 
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65) 

      expect(market.total_inventory).to eq({item1 => {quantity: 100, vendors: [vendor1, vendor3]},
        item2 => {quantity: 7, vendors: [vendor1]},
        item3 => {quantity: 25, vendors: [vendor2]},
        item4 => {quantity: 50, vendors: [vendor2]}})
    end
  end

  describe '#overstocked_items' do
    it 'can return a list of items if it is old by more than one vendor and its total quantity is greater than 50' do
      expect(market.overstocked_items).to eq([])

      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
      vendor1.stock(item1, 35) 
      vendor1.stock(item2, 7) 
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)  

      expect(market.overstocked_items).to eq([item1])
    end
  end

  describe '#sell' do
    it 'can search through the inventory of all vendors and return a boolean depending on total quantity. If True it can reduce inventory of specified quantity' do
      
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
      vendor1.stock(item1, 35) 
      vendor1.stock(item2, 7) 
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)  

      expect(market.sell(item2, 9)).to be false

      expect(market.sell(item1, 40)).to be true 
      expect(market.total_inventory).to eq({item1 => {quantity: 60, vendors: [vendor3]},
        item2 => {quantity: 7, vendors: [vendor1]},
        item3 => {quantity: 25, vendors: [vendor2]},
        item4 => {quantity: 50, vendors: [vendor2]}})
      expect(vendor1.inventory).to eq(item2 => 7)
      expect(vendor1.check_stock(item1)).to eq(0)
      expect(vendor3.inventory).to eq(item1 => 60)
    end
  end
  
end