json.set! :data do
  json.array! @category_logs do |category_log|
    json.partial! 'category_logs/category_log', category_log: category_log
    json.url  "
              #{link_to 'Show', category_log }
              #{link_to 'Edit', edit_category_log_path(category_log)}
              #{link_to 'Destroy', category_log, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end