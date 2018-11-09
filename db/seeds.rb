require_relative( "../models/session.rb" )
require_relative( "../models/member.rb" )
require_relative( "../models/booking.rb" )


Booking.delete_all()
Session.delete_all()
Member.delete_all()

session1 = Session.new({ "session_name" => "Zumba", "tier" => "Basic", "session_time" => "14:00" })
session1.save()

session2 = Session.new({ "session_name" => "Insanity", "tier" => "Platinum", "session_time" => "18:00" })
session2.save()

session3 = Session.new({ "session_name" => "Fitness", "tier" => "Basic", "session_time" => "10:00" })
session3.save()


member1 = Member.new({ "first_name" => "Borna", "last_name" => "Maticic", "tier" => "Platinum" })
member1.save()


member2 = Member.new({ "first_name" => "Aiste", "last_name" => "Maticic", "tier" => "Basic" })
member2.save()
member3 = Member.new({ "first_name" => "Olivia", "last_name" => "Maticic", "tier" => "Basic" })
member3.save()


booking1 = Booking.new({ "member_id" => member1.id, "session_id" => session1.id })
booking1.save()

booking2 = Booking.new({ "member_id" => member2.id, "session_id" => session2.id })
booking2.save()

booking3 = Booking.new({ "member_id" => member3.id, "session_id" => session3.id })
booking3.save()
