class CompanySerializer < Panko::Serializer
  attributes :id, :name, :avatar, :description

  has_many :schedules, serializer: ScheduleSerializer
end
