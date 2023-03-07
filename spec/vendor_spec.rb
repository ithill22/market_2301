require 'spec_helper'

RSpec.describe Vendor do
  let(:item1) {Item.new({name: 'Peach', price: "$0.75"})}
  let(:item2) {Item.new({name: 'Tomato', price: '$0.50'})}
  let(vendor) {Vendor.new("Rockey Mountain Fresh")}

  describe '#initialize' do
    it 'can initialize' do
      expect(vendor).to be_instance_of(Vendor)
      expect(vendor.name).to eq("Rocky Mountain Fresh")
      expect(vendor.inventory).to eq({})
    end
  end
end