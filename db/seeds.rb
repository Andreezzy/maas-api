user1 = User.create!(name: 'Bárbara', last_name: 'Bar', email: 'barbara@gmail.com', color: '#AAC4FF', password: '12345678', password_confirmation: '12345678', avatar: 'https://raw.githubusercontent.com/Andreezzy/profile-pictures/main/avatar-3.png')
user2 = User.create!(name: 'Andres', last_name: 'And', email: 'andres@gmail.com', color: '#B1B2FF', password: '12345678', password_confirmation: '12345678', avatar: 'https://raw.githubusercontent.com/Andreezzy/profile-pictures/main/avatar-1.png')
user3 = User.create!(name: 'Benjamin', last_name: 'Ben', email: 'benjamin@gmail.com', color: '#D2DAFF', password: '12345678', password_confirmation: '12345678', avatar: 'https://raw.githubusercontent.com/Andreezzy/profile-pictures/main/avatar-4.png')

company1 = Company.create!(name: 'Recorrido',         description: 'Recorrido.cl ofrece la posibilidad de encontrar el mejor viaje en bus interurbano para ti, ofreciendo una plataforma para comparar y comprar pasajes de bus interurbano dentro latino américa.', avatar: 'https://raw.githubusercontent.com/Andreezzy/profile-pictures/main/logo-recorrido.png')
company2 = Company.create!(name: 'Betterfly',         description: 'Betterfly proporciona una plataforma de beneficios digitales a través de la cual los empleadores pueden incentivar hábitos saludables entre sus empleados, como caminar o meditar.', avatar: 'https://raw.githubusercontent.com/Andreezzy/profile-pictures/main/logo-betterfly.jpeg')
company3 = Company.create!(name: 'Buk',               description: 'Buk es un software que te permite concentrar todas tus tareas en un solo lugar, desde la liquidación de nómina electrónica, hasta el desarrollo de talento de tus colaboradores.', avatar: 'https://raw.githubusercontent.com/Andreezzy/profile-pictures/main/logo-buk.jpeg')
company4 = Company.create!(name: 'Poliglota',         description: 'Poliglota es un lugar para aprender idiomas conversando. Nuestra metodología se basa en la práctica social, tal como aprendimos nuestra lengua materna, sumergidos en el idioma, acompañados de alguien que nos enseña y ayuda a seguir mejorando.', avatar: 'https://raw.githubusercontent.com/Andreezzy/profile-pictures/main/logo-poliglota.png')
company5 = Company.create!(name: 'CompartoMiMaletea', description: 'Comparto Mi Maleta trae tus compras desde cualquier lugar del mundo con un viajero de confianza', avatar: 'https://raw.githubusercontent.com/Andreezzy/profile-pictures/main/logo-cmm.png')

# Dates
date_at_11_07 = Date.new(2022, 11, 7) # 2022/11/07
date_at_11_08 = Date.new(2022, 11, 8) # 2022/11/08

# Times
time_at_06 = Time.new(0, 1, 1, 6) # 06:00
time_at_10 = Time.new(0, 1, 1, 10) # 10:00
time_at_17 = Time.new(0, 1, 1, 17) # 17:00
time_at_20 = Time.new(0, 1, 1, 20) # 20:00
time_at_23 = Time.new(0, 1, 1, 23) # 20:00

schedule1_1 = Schedule.create!(company_id: company1.id, start_date: date_at_11_08, end_date: date_at_11_08.end_of_week, min_time: time_at_06, max_time: time_at_20)
schedule2_1 = Schedule.create!(company_id: company2.id, start_date: date_at_11_08, end_date: date_at_11_08.end_of_week, min_time: time_at_10, max_time: time_at_23)

# Generate next 4 weeks
next_4_weeks_of_company1 = []
1.upto(4) do |i|
  week = date_at_11_08 + i.week
  next_4_weeks_of_company1 << Schedule.create!(company_id: company1.id, start_date: week.beginning_of_week(:sunday), end_date: week.end_of_week, min_time: time_at_06, max_time: time_at_20)
end

# days
monday_friday = [1, 2, 3, 4, 5]
weekend = [0, 6]

# We need BusinessHours to be able to select slots in the calendar

# Available days for schedule1_1 of company1 | Recorrido
monday_friday.each do |day|
  BusinessHour.create!(schedule_id: schedule1_1.id, day_of_week: day, start_time: time_at_06, end_time: time_at_20)
end
weekend.each do |day|
  BusinessHour.create!(schedule_id: schedule1_1.id, day_of_week: day, start_time: time_at_10, end_time: time_at_17)
end

# Set Available days for next_4_weeks_of_company of company1 | Recorrido
next_4_weeks_of_company1.each do |schedule|
  monday_friday.each do |day|
    BusinessHour.create!(schedule_id: schedule.id, day_of_week: day, start_time: time_at_06, end_time: time_at_20)
  end
  weekend.each do |day|
    BusinessHour.create!(schedule_id: schedule.id, day_of_week: day, start_time: time_at_10, end_time: time_at_17)
  end
end

# Available days for schedule2_1 of company2 | Betterfly
monday_friday.each do |day|
  BusinessHour.create!(schedule_id: schedule2_1.id, day_of_week: day, start_time: time_at_10, end_time: time_at_23)
end
weekend.each do |day|
  BusinessHour.create!(schedule_id: schedule2_1.id, day_of_week: day, start_time: time_at_06, end_time: time_at_17)
end

# schedule2_1 = Schedule.create(company_id: company2.id, start_date: '', end_date: '', min_time: '', max_time: '')
# schedule3_1 = Schedule.create(company_id: company3.id, start_date: '', end_date: '', min_time: '', max_time: '')
# schedule4_1 = Schedule.create(company_id: company4.id, start_date: '', end_date: '', min_time: '', max_time: '')

# kind { 0: draft, 1: published }
# draft Events for schedule schedule1_1
datetime_at_11_08 = DateTime.new(2022, 11, 8)
# user 1
Event.create!(schedule_id: schedule1_1.id, user_id: user1.id, kind: 0, start_time: datetime_at_11_08.change({hour: 10}), end_time: datetime_at_11_08.change({hour: 11}))
# user 2
Event.create!(schedule_id: schedule1_1.id, user_id: user2.id, kind: 0, start_time: datetime_at_11_08.change({hour: 9}), end_time: datetime_at_11_08.change({hour: 12}))
# user 3
Event.create!(schedule_id: schedule1_1.id, user_id: user3.id, kind: 0, start_time: datetime_at_11_08.change({hour: 8}), end_time: datetime_at_11_08.change({hour: 9}))
Event.create!(schedule_id: schedule1_1.id, user_id: user3.id, kind: 0, start_time: datetime_at_11_08.change({hour: 15}), end_time: datetime_at_11_08.change({hour: 18}))

# Generate official list of events
Events::SortPublishedEvents.new(schedule1_1.id).call
