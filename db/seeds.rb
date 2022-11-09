# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create(name: 'Jorge', last_name: 'Test', email: 'jorge@gmail.com', color: '#FF8787', avatar: 'https://github.com/Andreezzy/profile-pictures/blob/main/avatar-1.png')

company1 = Company.create(name: 'Recorrido',         description: 'Recorrido.cl ofrece la posibilidad de encontrar el mejor viaje en bus interurbano para ti, ofreciendo una plataforma para comparar y comprar pasajes de bus interurbano dentro latino américa.', avatar: 'https://raw.githubusercontent.com/Andreezzy/profile-pictures/main/logo-recorrido.png')
company2 = Company.create(name: 'Betterfly',         description: 'Betterfly proporciona una plataforma de beneficios digitales a través de la cual los empleadores pueden incentivar hábitos saludables entre sus empleados, como caminar o meditar.', avatar: 'https://raw.githubusercontent.com/Andreezzy/profile-pictures/main/logo-betterfly.jpeg')
company3 = Company.create(name: 'Buk',               description: 'Buk es un software que te permite concentrar todas tus tareas en un solo lugar, desde la liquidación de nómina electrónica, hasta el desarrollo de talento de tus colaboradores.', avatar: 'https://raw.githubusercontent.com/Andreezzy/profile-pictures/main/logo-buk.jpeg')
company4 = Company.create(name: 'Poliglota',         description: 'Poliglota es un lugar para aprender idiomas conversando. Nuestra metodología se basa en la práctica social, tal como aprendimos nuestra lengua materna, sumergidos en el idioma, acompañados de alguien que nos enseña y ayuda a seguir mejorando.', avatar: 'https://raw.githubusercontent.com/Andreezzy/profile-pictures/main/logo-poliglota.png')
company5 = Company.create(name: 'CompartoMiMaletea', description: 'Comparto Mi Maleta trae tus compras desde cualquier lugar del mundo con un viajero de confianza', avatar: 'https://raw.githubusercontent.com/Andreezzy/profile-pictures/main/logo-cmm.png')

today = Date.today
starts_at = Time.new(0,1,1,6) # 06:00
ends_at = Time.new(0,1,1,20) # 20:00

schedule_1_1 = Schedule.create(company_id: company1.id, start_date: today, end_date: today.end_of_week, min_time: starts_at, max_time: ends_at)
# Generate next 4 weeks
1.upto(4) do |i|
  week = today + i.week
  Schedule.create(company_id: company1.id, start_date: week.beginning_of_week(:sunday), end_date: week.end_of_week, min_time: starts_at, max_time: ends_at)
end

schedule_2_1 = Schedule.create(company_id: company2.id, start_date: today, end_date: today.end_of_week, min_time: Time.new(0,1,1,10), max_time: Time.new(0,1,1,23))
schedule_2_1 = Schedule.create(company_id: company2.id, start_date: '', end_date: '', min_time: '', max_time: '')
schedule_3_1 = Schedule.create(company_id: company3.id, start_date: '', end_date: '', min_time: '', max_time: '')
schedule_4_1 = Schedule.create(company_id: company4.id, start_date: '', end_date: '', min_time: '', max_time: '')

# days
monday_friday = [1, 2, 3, 4, 5]
weekend = [0, 6]
monday_friday.each do |day|
  BusinessHour.create!(schedule_id: schedule_1_1.id, day_of_week: day, start_time: starts_at, end_time: ends_at)
end
weekend.each do |day|
  BusinessHour.create!(schedule_id: schedule_1_1.id, day_of_week: day, start_time: Time.new(0,1,1,10), end_time: Time.new(0,1,1,17))
end
