json.set! :data do
  json.array! @user_logs do |user_log|
    json.partial! 'user_logs/user_log', user_log: user_log
    json.url  "
              #{link_to 'Show', user_log }
              #{link_to 'Edit', edit_user_log_path(user_log)}
              #{link_to 'Destroy', user_log, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end