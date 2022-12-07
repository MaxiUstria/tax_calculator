# frozen_string_literal: true

require './product_parser'
require './tax_calculator'

module Main
  response = gets.chomp
  products = []

  while response != ''
    product_information = ::ProductParser.parse(response)
    tax_information = ::TaxCalculator.calculate(product_information)

    product_information[:price_with_tax] = tax_information.first
    product_information[:sales_tax] = tax_information.last
    products.push(product_information)

    response = gets.chomp
  end

  products.each do |product|
    puts "#{product[:amount]} #{product[:name]}: #{product[:price_with_tax]}"
  end

  sales_tax = products.sum { |product| product[:sales_tax] }
  total = products.sum { |product| product[:price_with_tax] }
  puts "Sales Taxes: #{'%.2f' % sales_tax}"
  puts "Total: #{total}"

rescue StandardError
  puts 'Invalid input, please try again'
end
