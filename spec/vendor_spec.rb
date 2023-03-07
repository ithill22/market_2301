require 'spec_helper'

RSpec.describe Vendor do
  let(:item1) {Item.new({name: 'Peach', price: "$0.75"})}
  let(:item2) {Item.new({name: 'Tomato', price: '$0.50'})}
  let(:vendor) {Vendor.new("Rocky Mountain Fresh")}

  describe '#initialize' do
    it 'can initialize' do
      expect(vendor).to be_instance_of(Vendor)
      expect(vendor.name).to eq("Rocky Mountain Fresh")
      expect(vendor.inventory).to eq({})
    end
  end

  describe '#check_stock' do
    it 'can find items in the inventory and return the quantity' do
      expect(vendor.check_stock(item1)).to eq(0)
    end
  end

  describe '#stock' do
    it 'can add an item hash to inventory' do
      vendor.stock(item1, 30)
      
      expect(vendor.inventory).to eq(item1 => 30)
      expect(vendor.check_stock(item1)).to eq(30)
    end
  end


end