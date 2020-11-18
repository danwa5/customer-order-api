# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



product1 = Product.find_or_create_by(name: 'Rib Eye Steak', list_price: '45.50')
product2 = Product.find_or_create_by(name: 'Garlic Bread', list_price: '5.00')
product3 = Product.find_or_create_by(name: 'Oat Milk', list_price: '6.99')
product4 = Product.find_or_create_by(name: 'Brussel Sprouts', list_price: '4.99')


# Order 1
customer = Customer.find_or_create_by(email: 'foo@gmail.com')
order = Order.find_or_initialize_by(customer: customer)
order.update!(order_date: 1.month.ago)

[product1, product2, product3].each do |product|
  ol = OrderLine.find_or_initialize_by(order: order, product: product)
  ol.update!(product_name: product.name, quantity: (1..10).to_a.sample)
end

# Order 2
customer = Customer.find_or_create_by(email: 'bar@gmail.com')
order = Order.find_or_initialize_by(customer: customer)
order.update!(order_date: 1.week.ago)

[product2, product3, product4].each do |product|
  ol = OrderLine.find_or_initialize_by(order: order, product: product)
  ol.update!(product_name: product.name, quantity: (1..10).to_a.sample)
end

# Order 3
customer = Customer.find_or_create_by(email: 'baz@gmail.com')
order = Order.find_or_initialize_by(customer: customer)
order.update!(order_date: Time.now)

[product1, product2, product3, product4].each do |product|
  ol = OrderLine.find_or_initialize_by(order: order, product: product)
  ol.update!(product_name: product.name, quantity: (1..10).to_a.sample)
end
