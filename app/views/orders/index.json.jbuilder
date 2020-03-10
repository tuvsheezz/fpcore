json.set! :data do
  json.array! @orders do |order|
    json.partial! 'orders/order', order: order
    json.url  "
              #{link_to 'Show', order }
              #{link_to 'Edit', edit_order_path(order)}
              #{link_to 'Destroy', order, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end