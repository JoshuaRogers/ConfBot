require 'rubygems'
require 'sqlite3'
require_relative 'connection'
require_relative 'message'
require_relative 'plugin'

class Application

  def initialize
    @connections = []
    @plugins = []
  end

  def start
    start_database
    start_plugins
    start_connections
  end

  def stop
    @db.close
  end

  private
  def start_database
    @db = SQLite3::Database.new("confbot.db")
    @db.results_as_hash = true

    # Create the database if it doesn't exist.
    unless @db.execute("SELECT * FROM sqlite_master").length > 0
      @db.execute %q{
        CREATE TABLE connections (
          id INTEGER AUTO_INCREMENT,
          host VARCHAR(256),
          port INTEGER,
          username VARCHAR(256),
          password VARCHAR(256)
        )
      }
    end
  end

  def start_connections
    @db.execute("SELECT * FROM connections").each do |c|
      connection = Connection.new(c["host"], c["port"]).connect(c["username"], c["password"])
      connection.available
      connection.message_callback = lambda do |m| process_message(connection, m) end
      @connections << connection
    end
  end
  
  def start_plugins
    Dir.new("plugin").each do |file|
      require_relative "plugin/#{file}" if file =~ /\.rb$/
    end
    
    Plugin.list.each do |class_type| 
      plugin = class_type.new
      plugin.activate
      @plugins << plugin
    end
    
    @plugins = @plugins.sort { |x,y| x.sort_order <=> y.sort_order }
  end

  def process_message(connection, message)
    @plugins.each do |p|
      message = p.send message
    end
    
    return if message.invalid?

    message.reciptients.each do |r|
      connection.send(r.jid, message.print)
    end
  end

end

$application = Application.new
$application.start

gets
