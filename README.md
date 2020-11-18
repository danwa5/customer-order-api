# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


curl "http://localhost:3000/api/v1/orders?email=foo@gmail.com"


curl -d '{"email":"email", "order":[{"product_id":"1", "qty": "5"}, {"product_id":"2", "qty": "10"}]}' -H "Content-Type: application/json" -X POST "http://localhost:3000/api/v1/orders"



curl "http://localhost:3000/api/v1/product_sales?start_date=2020-10-01&end_date=2020-12-01&unit=date"
