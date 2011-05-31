# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'connection'

class Application

  @@plugins = []
  @@connections = []
  @@users = []

  # Registers a given plugin within the application
  def self.add_plugin(plugin)
    @@plugins << plugin unless @@plugins.index(plugin)
  end

  def self.delete_plugin(plugin)
    @@plugins.delete(plugin)
  end

  def self.start
    
  end

end

Application.start