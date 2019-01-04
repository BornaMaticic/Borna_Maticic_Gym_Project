require( 'pg' )
require ('chronic')


class SqlRunner

  def self.run( sql, values = [] )
    con = PG.connect :dbname => 'ruby', :user => 'root'
    puts con.server_version

    dbs = con.exec('SELECT datname FROM pg_database WHERE datistemplate = false;')

    dbs.each do |db|
      puts db
    end
    return result
  end

end



con.close
