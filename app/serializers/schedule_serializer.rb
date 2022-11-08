class ScheduleSerializer < Panko::Serializer
  attributes :id, :name, :company_id, :validRange, :slotMinTime, :slotMaxTime, :businessHours

  def name
    "Semana ##{object.start_date.strftime('%U').to_i}"
  end

  def validRange
    {
      start: object.start_date,
      end: object.end_date
    }
  end

  def slotMinTime
    object.min_time.strftime('%H:%M:%S')
  end

  def slotMaxTime
    object.max_time.strftime('%H:%M:%S')
  end

  def businessHours
    []
  end
end
