json.set! :data do
  json.array! @prodchanges do |prodchange|
    json.partial! 'prodchanges/prodchange', prodchange: prodchange
    json.url  "
              #{link_to 'Show', prodchange }
              #{link_to 'Edit', edit_prodchange_path(prodchange)}
              #{link_to 'Destroy', prodchange, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end