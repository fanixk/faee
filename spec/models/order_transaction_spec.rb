require 'spec_helper'

describe OrderTransaction do
  it { should respond_to(:response=) }

  context 'with valid response obj' do
    it 'sets its attrs by response obj' do
      order = FactoryGirl.create(:order)
      response  = Response.new
      transaction = OrderTransaction.create!(:action => "purchase", :amount => order.price_in_cents, :response => response, :order_id => order.id)
      transaction.message.should == 'test'
      transaction.authorization.should == 1
      transaction.success?.should == true
      transaction.params.should == { test: 'test' }
    end
  end
end


class Response
  attr_accessor :message, :authorization, :params
  def initialize
    @message = 'test'
    @authorization = 1
    @params = { test: 'test' }
  end

  def success?
    true
  end
end