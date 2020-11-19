class CreateOrder
  def initialize(email: email, order_data: order_data)
    @email = email
    @order_data = order_data || []
  end

  def call
    raise 'Insufficient order data' if @email.blank? || invalid_order_data?

    order = nil

    ActiveRecord::Base.transaction do
      customer = Customer.find_or_create_by!(email: @email)
      order = Order.create!(customer: customer, order_date: Time.now, status: 'ready')

      @order_data.each do |d|
        product = Product.find(d['product_id'])

        OrderLine.create!(
          order: order,
          product: product,
          product_name: product.name,
          quantity: d['qty'],
          unit: d['unit']
        )
      end
    end

    order
  end

  private

  def invalid_order_data?
    @order_data.empty? || invalid_order_keys? || invalid_order_values?
  end

  def invalid_order_keys?
    @order_data.any? { |h| h.keys != %w(product_id qty unit) }
  end

  def invalid_order_values?
    @order_data.any? { |h| h.values.any?(&:blank?) }
  end
end
