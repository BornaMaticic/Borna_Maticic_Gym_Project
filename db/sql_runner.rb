require( 'pg' )
require ('chronic')


class SqlRunner

  def self.run( sql, values = [] )
    begin
      db = PG.connect({ dbname: 'd4r3ubcs7300aa', host: 'ec2-107-22-162-8.compute-1.amazonaws.com', port: 5432, user: 'fwjaoplamyofdd', password: '1d866b67f8bab766e648d5d6cd9b48ada6d216b3be89fa1a0a17e63fcd92e794' })
      db.prepare("query", sql)
      result = db.exec_prepared( "query", values )
    ensure
      db.close() if db != nil
    end
    return result
  end

end
