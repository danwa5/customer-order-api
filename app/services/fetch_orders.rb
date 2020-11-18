class FetchOrders
  def initialize(email: email)
    @email = email
  end

  def call
    customer = Customer.find_by!(email: @email)
    Order.where(customer_id: customer.id).order(order_date: :desc)
  end
end
