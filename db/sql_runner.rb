require( 'pg' )
require ('chronic')


class SqlRunner

  def self.run( sql, values = [] )
    begin
      db = PG.connect({ dbname: 'd5puffjtetj6sh', host: 'ec2-54-247-82-210.eu-west-1.compute.amazonaws.com', port: 5432, user: 'hcuzlpnoozladd', password: '734bebf6b1dcd32045b8aa939efba3983cea0e56687a215b77ba6186b411dee9' })
      db.prepare("query", sql)
      result = db.exec_prepared( "query", values )
    ensure
      db.close() if db != nil
    end
    return result
  end

end
