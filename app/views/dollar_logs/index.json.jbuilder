json.set! :data do
  json.array! @dollar_logs do |dollar_log|
    json.partial! 'dollar_logs/dollar_log', dollar_log: dollar_log
    json.url  "
              #{link_to 'Show', dollar_log }
              #{link_to 'Edit', edit_dollar_log_path(dollar_log)}
              #{link_to 'Destroy', dollar_log, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end