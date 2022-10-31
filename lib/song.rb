class Song

  attr_accessor :name, :album, :id

  def initialize(name:, album:, id: nil)
    @id = id
    @name = name
    @album = album
  end

  #to be able to map our class , create a table within class

  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS songs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        album TEXT
      )
      SQL
    DB[:conn].execute(sql)
  end

  #Inserting Data into a table with the #save Method

  def save 
    sql = <<-SQL
      INSERT INTO songs (name, album)
      VALUES(?,?)
    SQL
#ending the save method with SQL query to grab the value of the id column of the last inserted row, and set the equal to the given song instance;s id atttribute.

  # insert the song
    DB[ :conn].execute(sql, self.name, self.album)

  # get the song ID from the database and save it to the Ruby instance
  self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]

  #return the ruby instance
  self
  end
  #The .create Method
  def self.create(name:, album:)
    song = Song.new(name: name, album: album)
    song.save
  end
end

