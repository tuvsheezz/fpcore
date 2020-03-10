json.set! :data do
  json.array! @machigainaoshis do |machigainaoshi|
    json.partial! 'machigainaoshis/machigainaoshi', machigainaoshi: machigainaoshi
    json.url  "
              #{link_to 'Show', machigainaoshi }
              #{link_to 'Edit', edit_machigainaoshi_path(machigainaoshi)}
              #{link_to 'Destroy', machigainaoshi, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end