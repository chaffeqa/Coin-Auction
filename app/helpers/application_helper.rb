module ApplicationHelper
  def time_left(end_datetime, current_datetime=@time||Time.now)
    tl = end_datetime - current_datetime
    if tl < 0
      return "Ended"
    end
    tl.to_time
  end

  def to_currency(decimal)
    number_to_currency(decimal)
  end
end
