# MaaS API

Rails Version: 7.0.4
Ruby Version: 3.1.2

## Instructions

### Development
This project is using [docker](https://www.docker.com/get-started) and [docker-compose](https://docs.docker.com/compose/install/) for development,
so, with these simple commands, you can have up and running you development environment.

```
docker-compose build
docker-compose up -d
docker-compose exec web bin/rails db:create db:migrate db:seed
```
### Go to the browser

```bash
http://localhost:3000/api/v1/users
```

### Test suite
As test suite we are using [rspec](https://rspec.info/) and [FactoryBot](https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md),
to run the test suite, execute the following commands.

```bash
docker-compose exec web rspec spec/
```

## Models
### User
- name
- email
- password_digest
- color (display the color of the slot in the calendar)
- avatar
### Company
- name
- avatar
- description
### Schedule
- company_id: references
- start_date (the first date of the week, "2022/11/06")
- end_date (the last date of the week, "2022/11/12")
- min_time (the minimum time between all days of the week, "06:00")
- max_time (the maximum time between all days of the week, "22:00")
### BusinessHour
- schedule_id: references
- day_of_week (in the range of [0,1,2,3,4,5,6] when 0 in Sunday)
- start_time (start time of the day, "08:00")
- end_time (end time of the day, "22:00")
### Event
- schedule_id: references
- user_id: references
- kind (0 is draft and 1 is published)
- start_time (start_time of the event, "2022/11/06T08:00")
- end_time (end_time of the event, "2022/11/06T10:00")

## Generate published list of events
There are two kind of events:
- Draft is when the users select their turns.
- Published is automatically generated after each creation of a draft event, it cannot be changed by the user
```
Events::SortPublishedEvents.new(:schedule_id).call
```

The solution was implemented applying 3 principles:
- First fill the events that no one has taken with an Event with null id_user
- Then fill all the Events that do not have collisions, Events that nobody else took the same time
- Finally evaluate collisions by checking a user's hour counter, assigning the Event to the user with fewer hours