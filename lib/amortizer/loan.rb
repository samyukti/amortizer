module Amortizer

  require 'bigdecimal'
  require 'bigdecimal/util'

  class Loan
    attr_accessor :decimals

    def initialize(principal, rate, term)
      @principal = principal
      @rate      = rate
      @term      = term

      @valid = convert_to_bigdecimals && validate_inputs if inputs_are_numbers
      @rate /= (12 * 100) if @valid
    end

    def payment
      calculate_payment if @valid
    end

  private

    def calculate_payment
      if @rate == 0
        payment = (@principal / @term)
      else
        payment = @principal * ((@rate * ((1 + @rate) ** @term)) /
                                    (((1 + @rate) ** @term) - 1))
      end
      payment.nan? ? nil : payment.to_f.round(@decimals || 2)
    end

    def is_number?(input)
      true if Float(input) rescue false
    end

    def inputs_are_numbers
      is_number?(@principal) && is_number?(@rate) && is_number?(@term)
    end

    def convert_to_bigdecimals
      @principal = @principal.to_d
      @rate      = @rate.to_d
      @term      = @term.to_d
    end

    def validate_inputs
      (@principal >= 0.0) && (@rate >= 0.0) && (@term >= 1.0)
    end

  end

end
