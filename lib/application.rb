# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'sqlite3'
require 'connection'
require 'message'

class Application

  def initialize
    @plugins = []
    @connections = []
    @users = []
  end

  def start
    start_database
    start_connections
    start_plugins
  end

  def stop
    @db.close
  end

  def process_message(connection, message)
    @plugins.each do |p|
      message = p.send message
      return if !message or message.invalid?
    end

    message.reciptients.each do |r|
      connection.send(r, message.print)
    end
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
      @db.execute %q{
        CREATE TABLE plugins (
          id INTEGER AUTO_INCREMENT,
          filename VARCHAR(128),
          classname VARCHAR(64),
          load INTEGER,
          priority INTEGER
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
    @db.execute("SELECT * FROM plugins WHERE load = 1 ORDER BY priority ASC").each do |p|
      require "plugin/#{p['filename']}"
      plugin = Kernel.const_get(p["classname"]).new
      @plugins << plugin unless @plugins.index(plugin)
      
      plugin.activate
    end
  end

end

Application.new.start
gets