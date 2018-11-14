require_relative( '../db/sql_runner' )
require('date')

class Member

  attr_reader( :first_name, :last_name, :membership_type, :date_joined, :id )

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @membership_type = options['membership_type']
    @date_joined = options['date_joined']
  end

  def save()
    sql = "INSERT INTO members
    (
      first_name,
      last_name,
      membership_type,
      date_joined
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING id"
    values = [@first_name, @last_name, @membership_type, @date_joined]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end



  def update()
      sql = "UPDATE members
      SET
      (
        first_name,
        last_name,
        membership_type,
        date_joined
      ) =
      (
        $1, $2, $3, $4
      )
      WHERE id = $5"
      values = [@first_name, @last_name, @membership_type, @date_joined, @id]
      SqlRunner.run(sql, values)
    end

    def delete()
      sql = "DELETE FROM members
      WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end

    def self.map_items(member_data)
      return member_data.map { |member| Member.new(member) }
    end

    def format_name
      return "#{@first_name.capitalize} #{@last_name.capitalize}"
    end

    def date_and_time
     time = Time.now
     return time
    end

    def session_name()
      sql = "SELECT s.* FROM sessions s INNER JOIN bookings b ON b.session_id = s.id WHERE b.member_id = $1;"
      values = [@id]
      session_array = SqlRunner.run(sql, values).to_a
      if session_array.length > 0
        session = session_array[0]
        return session ['session_name']
      else
        return "No session booked."
      end
    end

    def session()
      sql = "SELECT s.* FROM sessions s INNER JOIN bookings b ON b.session_id = s.id WHERE b.member_id = $1;"
      values = [@id]
      results = SqlRunner.run(sql, values)
      return results.map { |session| Session.new(session) }
    end


    def membership_types
      sql = "SELECT members.membership_type
      FROM members
      INNER JOIN sessions
      ON members.membership_type = sessions.membership_type
      WHERE sessions.id =$1"
      values = [@id]
      result = SqlRunner.run(sql, values)
      return results.map { |member| Member.new(members)}
    end

  def self.all()
    sql = "SELECT * FROM members"
    results = SqlRunner.run( sql )
    return results.map { |member| Member.new( member ) }
  end

  def self.find( id )
    sql = "SELECT * FROM members
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Member.new( results.first )
  end

  def self.delete_all
    sql = "DELETE FROM members"
    SqlRunner.run( sql )
  end


  def time_expired
    membership_expiry_date = Date.today - 30
    if membership_expiry_date >= Date.parse(@date_joined)
      return "Please renew your membership."
    end
  else
    return "OK"
  end

end
