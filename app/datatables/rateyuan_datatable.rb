class RateyuanDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    @view_columns ||= {
      rate: { source: "Rateyuan.rate", cond: :like},
      created_at: { source: "Rateyuan.created_at", cond: :like},
      user_name: { source: "User.where(id: Rateyuan.user_id).first.name", cond: :like}
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
    Rateyuan.all
  end
end
