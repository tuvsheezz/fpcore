json.set! :data do
  json.array! @yuan_logs do |yuan_log|
    json.partial! 'yuan_logs/yuan_log', yuan_log: yuan_log
    json.url  "
              #{link_to 'Show', yuan_log }
              #{link_to 'Edit', edit_yuan_log_path(yuan_log)}
              #{link_to 'Destroy', yuan_log, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end