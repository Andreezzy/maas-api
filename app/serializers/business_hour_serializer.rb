class BusinessHourSerializer < Panko::Serializer
  attributes :id, :schedule_id, :daysOfWeek, :startTime, :endTime

  def daysOfWeek
    [object.day_of_week]
  end

  def startTime
    object.start_time.strftime('%H:%M:%S')
  end

  def endTime
    object.end_time.strftime('%H:%M:%S')
  end
end
