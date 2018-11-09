require_relative( '../db/sql_runner' )

class Member

  attr_reader( :first_name, :last_name, :tier, :id )

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @tier = options['tier']
  end

  def save()
    sql = "INSERT INTO members
    (
      first_name,
      last_name,
      tier
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@first_name, @last_name, @tier]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end


  def update()
      sql = "UPDATE members
      SET
      (
        first_name,
        last_time,
        tier
      ) =
      (
        $1, $2, $3
      )
      WHERE id = $4"
      values = [@first_name, @last_time, @tier, @id]
      SqlRunner.run(sql, values)
    end

    def delete()
      sql = "DELETE FROM members
      WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end


  def session()
    sql = "SELECT s.* FROM sessions s INNER JOIN bookings b ON b.session_id = s.id WHERE b.member_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |session| Session.new(session) }
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

end