# frozen_string_literal: true

require './tax_calculator'
RSpec.describe 'TaxCalculator' do
  describe '.calculate' do
    let(:product) do
      { price: 27.99, amount: 1, type: 'not_exempt', imported: true, name: ' imported bottle of perfume' }
    end

    subject(:tax_information) { TaxCalculator.calculate(product) }

    it 'returns the correct price with tax' do
      expect(tax_information.first).to eq(32.19)
      expect(tax_information.last).to eq(4.2)
    end

    context 'when the product is not imported and not exempt' do
      let(:product) { { price: 14.99, amount: 1, type: 'not_exempt', imported: false, name: ' music CD' } }

      it 'returns the correct price with tax' do
        expect(tax_information.first).to eq(16.49)
        expect(tax_information.last).to eq(1.5)
      end
    end

    context 'when the product is imported and exempt' do
      let(:product) do
        { price: 10.00, amount: 1, type: 'exempt', imported: true, name: ' imported box of chocolates' }
      end

      it 'returns the correct price with tax' do
        expect(tax_information.first).to eq(10.5)
        expect(tax_information.last).to eq(0.5)
      end
    end

    context 'when the product is not imported and exempt' do
      let(:product) { { price: 0.85, amount: 1, type: 'exempt', imported: false, name: ' box of chocolates' } }

      it 'returns the correct price with tax' do
        expect(tax_information.first).to eq(0.85)
        expect(tax_information.last).to eq(0.0)
      end
    end
  end
end
