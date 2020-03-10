json.set! :data do
  json.array! @factoryreturns do |factoryreturn|
    json.partial! 'factoryreturns/factoryreturn', factoryreturn: factoryreturn
    json.url  "
              #{link_to 'Show', factoryreturn }
              #{link_to 'Edit', edit_factoryreturn_path(factoryreturn)}
              #{link_to 'Destroy', factoryreturn, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end