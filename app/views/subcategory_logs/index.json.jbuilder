json.set! :data do
  json.array! @subcategory_logs do |subcategory_log|
    json.partial! 'subcategory_logs/subcategory_log', subcategory_log: subcategory_log
    json.url  "
              #{link_to 'Show', subcategory_log }
              #{link_to 'Edit', edit_subcategory_log_path(subcategory_log)}
              #{link_to 'Destroy', subcategory_log, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end