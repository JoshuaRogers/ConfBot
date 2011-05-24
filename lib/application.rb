# To change this template, choose Tools | Templates
# and open the template in the editor.

class Application

  def initialize
    @plugins = []
  end

  private
  def add_plugin(plugin)
    @plugins << plugin
  end

  attr_accessor :plugins
end

Application.new