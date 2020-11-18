class OrderSerializer
  include JSONAPI::Serializer

  attributes :order_date, :status

  attribute :order_items do |obj|
    OrderLineSerializer.new(obj.order_lines)
  end
end
