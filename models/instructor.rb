require_relative( '../db/sql_runner' )


class Instructor

  attr_reader( :name, :id )

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO instructors
    (name)
    VALUES
    ($1)
    RETURNING id"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end


  def update()
      sql = "UPDATE instructors
      SET
      name =
      $1
      WHERE id = $2"
      values = [@name, @id]
      SqlRunner.run(sql, values)
    end

    def delete()
      sql = "DELETE FROM instructors
      WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end

    def self.map_items(instructor_data)
      return instructor_data.map { |instructor| Instructor.new(instructor) }
    end

    def session_instructor()
      sql = "SELECT sessions.session_name
      FROM sessions
      INNER JOIN instructors
      ON sessions.instructor_id = instructors.id
      WHERE instructor_id = $1"
      values = [@id]
      session_array = SqlRunner.run(sql, values).to_a
      if session_array.length > 0
        session = session_array[0]
        return session ['session_name']
      else
        return "No classes booked."
      end
    end

    def sessions
      sql = "SELECT * FROM sessions
      WHERE instructor_id = $1"
      values = [@id]
      results = SqlRunner.run( sql, values )
      sessions = results.map { |session| Session.new(session)}
      return sessions
    end

  def self.all()
    sql = "SELECT * FROM instructors"
    results = SqlRunner.run( sql )
    return results.map { |instructor| Instructor.new( instructor ) }
  end

  def self.find( id )
    sql = "SELECT * FROM instructors
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Instructor.new( results.first )
  end

  def self.delete_all
    sql = "DELETE FROM instructors"
    SqlRunner.run( sql )
  end

end
