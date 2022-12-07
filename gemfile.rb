# frozen_string_literal: true

group :development, :test do
  gem 'rspec-rails', '~> 4.1'
end

group :test do
  gem 'shoulda-matchers', '~> 4.1', '>= 4.1.2'
end
