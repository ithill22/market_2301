require 'spec_helper'

RSpec.describe Item do
  let(:item1) {Item.new({name: 'Peach', price: "$0.75"})}
  let(:item2) {Item.new({name: 'Tomato', price: '$0.50'})}

  describe '#initialize' do
    it 'can initialize' do
      expect(item1).to be_instance_of(Item)
      expect(item1.name).to eq('Peach')
      expect(item1.price).to eq(0.75)
    end
  end
end