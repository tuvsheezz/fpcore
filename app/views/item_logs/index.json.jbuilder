json.set! :data do
  json.array! @item_logs do |item_log|
    json.partial! 'item_logs/item_log', item_log: item_log
    json.url  "
              #{link_to 'Show', item_log }
              #{link_to 'Edit', edit_item_log_path(item_log)}
              #{link_to 'Destroy', item_log, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end