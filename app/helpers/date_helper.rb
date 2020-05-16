# frozen_string_literal: true

module DateHelper
  def brazil_date(date)
    date.strftime('%d/%m/%Y - %H:%M:%S')
  end
end
