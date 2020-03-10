class ItemDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    @view_columns ||= {
      
    }
  end

  def data
    records.map do |record|
      {

      }
    end
  end

  def get_raw_records

  end

end
