# frozen_string_literal: true

module ProductParser
  IMPORT_DUTY = 'imported'
  BOOK = 'book'
  MEDICAL_SUPPLIES = 'pills'
  FOOD = 'chocolate'

  def self.parse(product)
    product_metadata = {}

    price_and_product_string = product.split(' at ')
    amount_and_name_string = price_and_product_string.first.split(/(?<=\d)/)

    raise :invalid_product_input if price_and_product_string.length != 2 || amount_and_name_string.length != 2

    product_metadata[:price] = price_and_product_string.last.to_f
    product_metadata[:amount] = amount_and_name_string.first.to_i
    product_metadata[:type] = get_product_type(amount_and_name_string.last.downcase)
    product_metadata[:imported] = get_product_imported(amount_and_name_string.last.downcase)
    product_metadata[:name] = amount_and_name_string.last

    product_metadata
  end

  def self.get_product_type(product_description)
    if product_description.include?(BOOK) ||
       product_description.include?(MEDICAL_SUPPLIES) ||
       product_description.include?(FOOD)
      return 'exempt'
    end

    'not_exempt'
  end

  def self.get_product_imported(product_description)
    return true if product_description.include?(IMPORT_DUTY)

    false
  end
end
