class EventSerializer < Panko::Serializer
  attributes :id, :title, :kind, :start, :end, :color, :user_id, :schedule_id

  def title
    object.user ? object.user.name : '⚠️'
  end

  def start
    object.start_time
  end

  def end
    object.end_time
  end

  def color
    object.user ? object.user.color : '#FF8787'
  end
end
