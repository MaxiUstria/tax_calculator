# frozen_string_literal: true

module TaxCalculator
  SALES_TAX = 0.1
  IMPORT_TAX = 0.05

  def self.calculate(product)
    price = product[:price]
    amount = product[:amount]
    type = product[:type]
    imported = product[:imported]

    price_with_tax = price
    tax = 0

    tax += price * SALES_TAX if type == 'not_exempt'
    tax += price * IMPORT_TAX if imported
    tax = round_by_five_cents(round_by_five_cents(tax) * amount)

    price_with_tax *= amount
    price_with_tax += tax

    [price_with_tax.round(2), tax.round(2)]
  end

  def self.round_by_five_cents(price)
    return price if ((price * 100) % 5).zero?

    price += 0.05 - (price % 0.05)

    price.round(2)
  end
end
