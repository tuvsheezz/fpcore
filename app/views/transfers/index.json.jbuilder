json.set! :data do
  json.array! @transfers do |transfer|
    json.partial! 'transfers/transfer', transfer: transfer
    json.url  "
              #{link_to 'Show', transfer }
              #{link_to 'Edit', edit_transfer_path(transfer)}
              #{link_to 'Destroy', transfer, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end