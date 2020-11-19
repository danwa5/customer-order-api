# Customer Order API

A Rails API with end points to fetch and create orders, and to retrieve a breakdown of product sales.

## Assumptions
1. API does not require authentication. Hence, an access token is not required when making a request.
2. If the quantity of an item is a decimal (e.g. 1.5), then the unit should be based on weight (pound/ounce).
A whole number quantity can be based on count or weight.
3. Many database indexes are missing that would increase database performance and enforce data integrity.
4. The API endpoint that returns all orders for a customer...
  - Returns order in descending order because
  most people are most interested in their most recent orders.
  - May not be best practice for reporting queries to hit the database directly. A data warehouse for production?

## With more time...
There is so much more to do with an API like this, but to start:
1. Include the price of items when creating an order.
2. Calculate the cost for each item.
3. Calculate order subtotal.
4. Prevent duplicate orders.
5. Add the option to paginate results.
6. Elaborate on API documentation.

## Development

### Initialization
```shell
$ gem install bundler
$ bundle check || bundle install
```

### Database

1. Create database and run migrations
```shell
$ rake db:setup
```

2. Populate with seed data
```shell
$ rails db:seed
```

### Start server
```shell
$ rails server
```

### Usages

Create an order for a customer
- `email` is customer's email
```shell
curl 'http://localhost:3000/api/v1/orders' \
  -X POST \
  -H 'Content-Type: application/json' \
  -d '{
    "email": "abc@gmail.com",
    "order": [
      { "product_id": 1, "qty": 1.75, "unit": "pound" }
    ]
  }'
```

Retrieve all orders for a customer
- `email` is customer's email
```shell
curl 'http://localhost:3000/api/v1/orders?email=abc@gmail.com' \
  -X GET \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json'
```

Retrieve a breakdown of products sold by quantity per day/week/month
- `start_date` and `end_date` should be in YYYY-MM-DD format
- `unit` should be "day" (default), "week", or "month"
```shell
curl 'http://localhost:3000/api/v1/product_sales?start_date=2020-10-01&end_date=2020-12-01&unit=day' \
  -X GET \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json'
```

### Run Test Suite
```shell
$ COVERAGE=true rspec
$ open coverage/index.html
```
