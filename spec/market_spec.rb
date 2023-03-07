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
end