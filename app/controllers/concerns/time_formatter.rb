module TimeFormatter
  extend ActiveSupport::Concern

  def format_time(date, time)
    return unless time.match(/^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/)

    date_time = [date, time].join(' ')
    DateTime.strptime(date_time, '%Y-%m-%d %H:%M')
  end
end
