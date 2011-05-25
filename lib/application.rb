# To change this template, choose Tools | Templates
# and open the template in the editor.

class Application

  def initialize
    @plugins = []
  end

  attr_accessor :plugins

  # Registers a given plugin within the application
  def add_plugin(plugin)
    @plugins << plugin
  end

end
