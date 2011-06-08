# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'sqlite3'
require 'connection'

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
    
  end

end

Application.new.start
