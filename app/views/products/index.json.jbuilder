json.set! :data do
  json.array! @products do |product|
    json.partial! 'products/product', product: product
    json.url  "
              #{link_to 'Show', product }
              #{link_to 'Edit', edit_product_path(product)}
              #{link_to 'Destroy', product, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end