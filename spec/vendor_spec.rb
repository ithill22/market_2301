require 'spec_helper'

RSpec.describe Vendor do
  let(:item1) {Item.new({name: 'Peach', price: "$0.75"})}
  let(:item2) {Item.new({name: 'Tomato', price: '$0.50'})}
  let(:item3) {Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})}
  let(:item4) {Item.new({name: "Banana Nice Cream", price: "$4.25"})}
  let(:vendor1) {Vendor.new("Rocky Mountain Fresh")}
  let(:vendor2) {Vendor.new("Ba-Nom-a-Nom")}
  let(:vendor3) {Vendor.new("Palisade Peach Shack")}

  describe '#initialize' do
    it 'can initialize' do
      expect(vendor1).to be_instance_of(Vendor)
      expect(vendor1.name).to eq("Rocky Mountain Fresh")
      expect(vendor1.inventory).to eq({})
    end
  end

  describe '#check_stock' do
    it 'can find items in the inventory and return the quantity' do
      expect(vendor1.check_stock(item1)).to eq(0)
    end
  end

  describe '#stock' do
    it 'can add an item hash to inventory' do
      vendor1.stock(item1, 30)
      
      expect(vendor1.inventory).to eq(item1 => 30)
      expect(vendor1.check_stock(item1)).to eq(30)

      vendor1.stock(item1, 25)
      vendor1.stock(item2, 12)

      expect(vendor1.check_stock(item1)).to eq(55)
      expect(vendor1.check_stock(item2)).to eq(12)
      expect(vendor1.inventory).to eq(item1 => 55, item2 => 12)
    end
  end

  describe '#potential_revenue' do
    it 'can return a vendors potential revenue based on its current inventory' do
      expect(vendor1.potential_revenue).to eq(0)

      vendor1.stock(item1, 35) 
      vendor1.stock(item2, 7) 
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)  

      expect(vendor1.potential_revenue).to eq(29.75)
      expect(vendor2.potential_revenue).to eq(345.00)
      expect(vendor3.potential_revenue).to eq(48.75)
    end
  end


end