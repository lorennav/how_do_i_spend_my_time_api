module TimeFormatter
  extend ActiveSupport::Concern

  def format_time(date, time)
    date_time = [date, time].join(' ')
    DateTime.strptime(date_time, '%Y-%m-%d %H:%M')
  end
end
