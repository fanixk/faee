class OrderTransaction < ActiveRecord::Base
  attr_accessible :action, :amount, :authorization, :message, :order_id, :params, :success, :response
  serialize :params

  def response=(response)
    self.success = response.success?
    self.message = response.message
    self.authorization = response.authorization
    self.params = response.params
  rescue ActiveMerchant::ActiveMerchantError => e
    self.success = false
    self.message = e.message
    self.authorization = nil
    self.params = {}
  end
end
