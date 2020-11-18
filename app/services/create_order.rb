class CreateOrder
  def initialize(email: email, order_data: order_data)
    @email = email
    @order_data = order_data || []
  end

  def call
    raise 'Insufficient order data' unless @email.present? && @order_data.any?

    order = nil

    ActiveRecord::Base.transaction do
      customer = Customer.find_or_create_by(email: @email)
      order = Order.create(customer: customer, order_date: Time.now)

      @order_data.each do |d|
        product = Product.find(d['product_id'])
        OrderLine.create(order: order, product: product, product_name: product.name, quantity: d['qty'])
      end
    end

    order
  end
end
