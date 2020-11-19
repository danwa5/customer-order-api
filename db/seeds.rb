# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

meat = Category.find_or_create_by!(name: 'Meat')
grains = Category.find_or_create_by!(name: 'Grains')
diary = Category.find_or_create_by!(name: 'Diary')
produce = Category.find_or_create_by!(name: 'Produce')
sale = Category.find_or_create_by!(name: 'Sale')

product1 = Product.find_or_create_by(name: 'Rib Eye Steak', list_price: '45.50')
product2 = Product.find_or_create_by(name: 'Garlic Bread', list_price: '5.00')
product3 = Product.find_or_create_by(name: 'Oat Milk', list_price: '6.99')
product4 = Product.find_or_create_by(name: 'Brussel Sprouts', list_price: '4.99')
product5 = Product.find_or_create_by(name: 'Fuji Apples', list_price: '0.79')

ProductCategory.find_or_create_by(product: product1, category: meat)
ProductCategory.find_or_create_by(product: product1, category: sale)
ProductCategory.find_or_create_by(product: product2, category: grains)
ProductCategory.find_or_create_by(product: product3, category: diary)
ProductCategory.find_or_create_by(product: product4, category: produce)
ProductCategory.find_or_create_by(product: product4, category: sale)
ProductCategory.find_or_create_by(product: product5, category: produce)

# Order 1
customer = Customer.find_or_create_by(email: 'foo@gmail.com')
order = Order.find_or_initialize_by(customer: customer)
order.update_attributes!(order_date: 1.month.ago)

[product1, product2, product3].each do |product|
  ol = OrderLine.find_or_initialize_by(order: order, product: product)
  ol.update_attributes!(
    product_name: product.name,
    quantity: (1..10).to_a.sample,
    unit: %w(count pound ounce).sample
  )
end

# Order 2
customer = Customer.find_or_create_by(email: 'bar@gmail.com')
order = Order.find_or_initialize_by(customer: customer)
order.update_attributes!(order_date: 1.week.ago)

[product2, product3, product4].each do |product|
  ol = OrderLine.find_or_initialize_by(order: order, product: product)
  ol.update_attributes!(
    product_name: product.name,
    quantity: (1..10).to_a.sample,
    unit: %w(count pound ounce).sample
  )
end

# Order 3
customer = Customer.find_or_create_by(email: 'baz@gmail.com')
order = Order.find_or_initialize_by(customer: customer)
order.update_attributes!(order_date: 3.days.ago)

[product1, product2, product3, product4].each do |product|
  ol = OrderLine.find_or_initialize_by(order: order, product: product)
  ol.update_attributes!(
    product_name: product.name,
    quantity: (1..10).to_a.sample,
    unit: %w(count pound ounce).sample
  )
end

# Order 4
customer = Customer.find_or_create_by(email: 'xyz@gmail.com')
order = Order.find_or_initialize_by(customer: customer)
order.update_attributes!(order_date: Time.now)

[product3, product4, product5].each do |product|
  ol = OrderLine.find_or_initialize_by(order: order, product: product)
  ol.update_attributes!(
    product_name: product.name,
    quantity: (1..10).to_a.sample,
    unit: %w(count pound ounce).sample
  )
end
