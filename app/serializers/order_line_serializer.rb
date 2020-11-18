class OrderLineSerializer
  include JSONAPI::Serializer

  attributes :product_id, :product_name
end
