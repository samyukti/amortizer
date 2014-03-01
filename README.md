# Amortizer

A simple gem to calculate amortizing loan payments, as part of training at Samyukti

## Installation

Add this line to your application's Gemfile:

    gem 'amortizer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install amortizer

## Usage


    require 'amortizer'
    include Amortizer

    loan = Loan.new(1000000, 10.5, 120)
    loan.payment

Please see the spec for more examples.

## Contributing

1. Fork it ( http://github.com/samyukti/amortizer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
