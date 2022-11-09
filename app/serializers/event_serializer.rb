class EventSerializer < Panko::Serializer
  attributes :id, :title, :start, :end, :backgroundColor, :borderColor, :user_id, :schedule_id

  def title
    object.user ? object.user.name : '⚠️'
  end

  def start
    object.start_time
  end

  def end
    object.end_time
  end

  def backgroundColor
    object.user ? object.user.color : '#FF0000'
  end

  def borderColor
    object.user ? object.user.color : '#FF0000'
  end
end
