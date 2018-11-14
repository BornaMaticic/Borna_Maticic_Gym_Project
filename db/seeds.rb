require_relative( "../models/session.rb" )
require_relative( "../models/member.rb" )
require_relative( "../models/booking.rb" )
require_relative( "../models/instructor.rb" )


Booking.delete_all()
Session.delete_all()
Member.delete_all()
Instructor.delete_all()



instructor1 = Instructor.new({ "name" => "Zed" })
instructor1.save()

instructor2 = Instructor.new({ "name" => "Connor" })
instructor2.save()

instructor3 = Instructor.new({ "name" => "Mathew" })
instructor3.save()


session1 = Session.new({ "session_name" => "Zumba", "membership_type" => "Basic", "session_time" => "14:00", "capacity" => "20", "instructor_id" => instructor1.id })
session1.save()

session2 = Session.new({ "session_name" => "Insanity", "membership_type" => "Platinum", "session_time" => "18:00", "capacity" => "15", "instructor_id" => instructor2.id })
session2.save()

session3 = Session.new({ "session_name" => "Fitness", "membership_type" => "Gold", "session_time" => "10:00", "capacity" => "10", "instructor_id" => instructor3.id })
session3.save()


member1 = Member.new({ "first_name" => "Borna", "last_name" => "Maticic", "membership_type" => "Platinum", "date_joined" => '2018-11-14' })
member1.save()
p member1.time_expired

member2 = Member.new({ "first_name" => "Aiste", "last_name" => "Maticic", "membership_type" => "Basic", "date_joined" => '2018-11-11'  })
member2.save()
member3 = Member.new({ "first_name" => "Olivia", "last_name" => "Maticic", "membership_type" => "Gold", "date_joined" => '2018-11-07' })
member3.save()


booking1 = Booking.new({ "member_id" => member1.id, "session_id" => session1.id })
booking1.save()

booking2 = Booking.new({ "member_id" => member2.id, "session_id" => session2.id })
booking2.save()

booking3 = Booking.new({ "member_id" => member3.id, "session_id" => session3.id })
booking3.save()
