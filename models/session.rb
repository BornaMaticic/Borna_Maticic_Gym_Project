require_relative( '../db/sql_runner' )

class Session

  attr_reader( :session_name, :session_time, :membership_type, :capacity, :id )

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @session_name = options['session_name']
    @session_time = options['session_time']
    @membership_type = options['membership_type']
    @capacity = options['capacity'].to_i
  end

  def save()
    sql = "INSERT INTO sessions
    (
      session_name,
      session_time,
      membership_type,
      capacity
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING id"
    values = [@session_name, @session_time, @membership_type, @capacity]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "UPDATE sessions
    SET
    (
      session_name,
      session_time,
      membership_type,
      capacity
      ) =
      (
        $1, $2, $3, $4
      )
      WHERE id = $5"
      values = [@session_name, @session_time, @membership_type, @capacity, @id]
      SqlRunner.run(sql, values)
    end

    def delete()
      sql = "DELETE FROM sessions
      WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end

    def self.map_items(session_data)
      return session_data.map { |session| Session.new(session) }
    end

    def member
      sql = "SELECT m.* FROM members m INNER JOIN bookings b ON b.member_id = m.id WHERE b.session_id = $1;"
      values = [@id]
      results = SqlRunner.run(sql, values)
      return results.map { |member| Member.new(member) }
    end

    def self.all()
      sql = "SELECT * FROM sessions"
      results = SqlRunner.run( sql )
      return results.map { |session| Session.new( session ) }
    end

    def self.find( id )
      sql = "SELECT * FROM sessions
      WHERE id = $1"
      values = [id]
      results = SqlRunner.run( sql, values )
      return Session.new( results.first )
    end

    def self.delete_all
      sql = "DELETE FROM sessions"
      SqlRunner.run( sql )
    end

    def members_count
      Member.all.count
    end

    def session_full?
      if members_count >= @capacity
        return true
      else
        return false
      end
    end

    def self.available_sessions
      all_sessions = self.all
      all_sessions.find_all do |session|
        !session.session_full?
      end
    end

    def remaining_spaces
      empty_spaces = @capacity - members_count
      if empty_spaces > 0
        return empty_spaces
      else
        return "No space left."
      end
    end

  end
