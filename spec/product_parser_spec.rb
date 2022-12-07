# frozen_string_literal: true

require './product_parser'

RSpec.describe 'ProductParser' do
  describe '.parse' do
    subject(:product_information) { ProductParser.parse(product) }

    context 'when the product is invalid' do
      let!(:product) { 'invalid product' }
      it 'raises an error' do
        expect { ProductParser.parse(product) }.to raise_error(StandardError)
      end
    end

    context 'when the product is imported and not exempt' do
      let!(:product) { '1 imported bottle of perfume at 27.99' }
      it 'returns the correct product information' do
        expect(product_information).to eq({
                                            price: 27.99,
                                            amount: 1,
                                            type: 'not_exempt',
                                            imported: true,
                                            name: ' imported bottle of perfume'
                                          })
      end
    end

    context 'when the product is imported and exempt' do
      let!(:product) { '1 imported box of chocolates at 10.00' }
      it 'returns the correct product information' do
        expect(product_information).to eq({
                                            price: 10.00,
                                            amount: 1,
                                            type: 'exempt',
                                            imported: true,
                                            name: ' imported box of chocolates'
                                          })
      end
    end

    context 'when the product is not imported and not exempt' do
      let!(:product) { '1 music CD at 14.99' }
      it 'returns the correct product information' do
        expect(product_information).to eq({
                                            price: 14.99,
                                            amount: 1,
                                            type: 'not_exempt',
                                            imported: false,
                                            name: ' music CD'
                                          })
      end
    end
  end
end
