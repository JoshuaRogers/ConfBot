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
    load_database
    load_connections
    load_plugins
  end

  def stop
    @db.close
  end

  # Registers a given plugin within the application
  def add_plugin(plugin)
    @plugins << plugin unless @plugins.index(plugin)
  end

  def delete_plugin(plugin)
    @plugins.delete(plugin)
  end

  def process_message(connection, message)
    puts connection
    puts message
  end

  private
  def load_database
    @db = SQLite3::Database.new("confbot.db")
    @db.results_as_hash = true

    # Create the database if it doesn't exist.
    unless @db.execute("SELECT * FROM sqlite_master")
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
          load INTEGER,
          version INTEGER
        )
      }
    end
  end

  def load_connections
    @db.execute("SELECT * FROM connections").each do |c|
      connection = Connection.new(c["host"], c["port"]).connect(c["username"], c["password"])
      connection.available
      connection.message_callback = lambda do |m| process_message(connection, m) end
      @connections << connection
    end
  end

  def load_plugins
    @db.execute("SELECT * FROM plugins WHERE load = 1").each do |p|
      require "plugins/#{p['filename']}"

      
    end
  end

end

Application.new.start
gets