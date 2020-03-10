class RatedollarDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    @view_columns ||= {
      rate: { source: "Ratedollar.rate", cond: :like},
      created_at: { source: "Ratedollar.created_at", cond: :like},
      user_name: { source: "User.where(id: Ratedollar.user_id).first.name", cond: :like}
    }
  end

  def data
    records.map do |record|
      {
        rate: record.rate,
        created_at: record.created_at,
        user_name: User.where(id: record.user_id).first.name
      }
    end
  end

  def get_raw_records
    Ratedollar.all
  end
end
