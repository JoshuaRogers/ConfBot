# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'sqlite3'
require 'connection'
require 'message'

class Application

  @plugins = []
  @connections = []
  @users = []

  # Registers a given plugin within the application
  def add_plugin(plugin)
    @plugins << plugin unless @plugins.index(plugin)
  end

  def delete_plugin(plugin)
    @plugins.delete(plugin)
  end

  def start
    load_database
  end

  def stop
    
  end

  private
  def load_database
    @db = SQLite3::Database.new("confbot.db")
    @db.results_as_hash = true

    Connection.initialize_database(@db)
    @db.close
  end

end
