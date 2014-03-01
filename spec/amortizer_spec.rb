require 'spec_helper'
include Amortizer

describe Loan do
  describe "#payment" do
    # valid scenarios
    it "returns 13493.5 for principal 1000000, rate 10.5, term 120" do
      loan = Loan.new(1000000, 10.5, 120)
      loan.payment.should == 13493.5
    end

    it "returns payment correctly, with rate as integer" do
      loan = Loan.new(1000000, 10, 120)
      loan.payment.should == 13215.07
    end

    it "returns payment correctly, if principal contains decimal" do
      loan = Loan.new(1000.1, 10.1, 110)
      loan.payment.should == 13.98
    end

    it "returns payment correctly, if term contains decimal" do
      loan = Loan.new(1000.1, 10.1, 10.1)
      loan.payment.should == 103.7
    end

    it "returns payment if principal, rate and term are strings of valid numbers" do
      loan = Loan.new("1000000", "10.5", "120")
      loan.payment.should == 13493.5
    end

    it "returns payment if the parameter is string of a valid number without integer part" do
      loan = Loan.new("1000000", ".5", "120")
      loan.payment.should == 8545.14
    end

    it "returns the same payment if the method is executed multiple times" do
      loan = Loan.new(1000000, 10, 120)
      loan.payment
      loan.payment.should == 13215.07
    end

    it "returns the payment without decimals if 0 decimals are specified" do
      loan = Loan.new(1000000, 10, 120)
      loan.decimals = 0
      loan.payment.should == 13215
    end

    it "returns the payment with 4 decimals if 4 decimals are specified" do
      loan = Loan.new(1000000, 10, 120)
      loan.decimals = 4
      loan.payment.should == 13215.0737
    end

    # edge scenarios
    it "returns 0 if the principal is 0" do
      loan = Loan.new(0, 1, 1)
      loan.payment.should == 0
    end

    it "returns principal in equal parts for term if the rate is 0" do
      loan = Loan.new(1, 0, 2)
      loan.payment.should == 0.5
    end

    it "returns payment if the term is equal to 1" do
      loan = Loan.new(100, 1, 1)
      loan.payment.should == 100.08
    end

    it "returns nil if the term is less than 1" do
      loan = Loan.new(100, 1, 0.99)
      loan.payment.should be_nil
    end

    it "returns nil if the term is less than 1" do
      loan = Loan.new(100, 1, "0.9999999999999999999".to_d)
      loan.payment.should be_nil
    end

    it "returns payment if the principal is very low" do
      loan = Loan.new(0.0000000001, 1.0, 1.0)
      loan.payment.should == 0.0
    end

    it "returns payment if the principal is very low" do
      loan = Loan.new(0.0000000001, 1.0, 1.0)
      loan.decimals = 20
      loan.payment.should == 1.0008333333e-10
    end

    it "returns payment if the rate is very low" do
      loan = Loan.new(1.0, 0.0000000001, 1.0)
      loan.decimals = 20
      loan.payment.should == 1.0000000000000833
    end

    it "returns payment if the principal is very large" do
      loan = Loan.new(99999999999999999999, 1.0, 1.0)
      loan.payment.should > 0
    end

    it "returns payment if the rate is very large" do
      loan = Loan.new(1.0, 99999999999999999999, 1.0)
      loan.payment.should > 0
    end

    it "returns payment if the term is very large and rate is 0" do
      loan = Loan.new(1.0, 0, 99999999999999999999)
      loan.decimals = 20
      loan.payment.should > 0
    end

    # invalid scenarios
    it "returns nil if the principal is negative" do
      loan = Loan.new(-0.1, 1.0, 1.0)
      loan.payment.should be_nil
    end

    it "returns nil if the rate is negative" do
      loan = Loan.new(1.0, -0.1, 1.0)
      loan.payment.should be_nil
    end

    it "returns nil if the term is negative" do
      loan = Loan.new(1.0, 1.0, -0.1)
      loan.payment.should be_nil
    end

    it "returns nil if the principal is string which does not convert to a number" do
      loan = Loan.new("x", "1", "1")
      loan.payment.should be_nil
    end

    it "returns nil if the rate is string which does not convert to a number" do
      loan = Loan.new("1", "x", "1")
      loan.payment.should be_nil
    end

    it "returns nil if the term is string which does not convert to a number" do
      loan = Loan.new("1", "5", "x")
      loan.payment.should be_nil
    end

    it "returns nil if the parameter is string of a valid number without decimal part" do
      loan = Loan.new("1", "5.", "1")
      loan.payment.should be_nil
    end

    it "returns nil if the term is very large and rate is 1" do
      loan = Loan.new(1.0, 1, 99999999999999999999)
      loan.decimals = 20
      loan.payment.should == nil
    end

    it "returns nil if the term is very large and rate is very small" do
      loan = Loan.new(1.0, 0.000000000000000001, 99999999999999999999)
      loan.decimals = 20
      loan.payment.should == nil
    end

  end
end