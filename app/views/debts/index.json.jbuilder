json.set! :data do
  json.array! @debts do |debt|
    json.partial! 'debts/debt', debt: debt
    json.url  "
              #{link_to 'Show', debt }
              #{link_to 'Edit', edit_debt_path(debt)}
              #{link_to 'Destroy', debt, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end