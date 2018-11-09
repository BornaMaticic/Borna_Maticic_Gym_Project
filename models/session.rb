require_relative( '../db/sql_runner' )

class Session

  attr_reader( :session_name, :session_time, :tier, :id )

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @session_name = options['session_name']
    @session_time = options['session_time']
    @tier = options['tier']
  end

  def save()
    sql = "INSERT INTO sessions
    (
      session_name,
      session_time,
      tier
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@session_name, @session_time, @tier]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
      sql = "UPDATE sessions
      SET
      (
        session_name,
        session_time,
        tier
      ) =
      (
        $1, $2, $3
      )
      WHERE id = $4"
      values = [@session_name, @session_time, @tier, @id]
      SqlRunner.run(sql, values)
    end

    def delete()
      sql = "DELETE FROM sessions
      WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end


  def members
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



end
