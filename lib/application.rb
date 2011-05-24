# To change this template, choose Tools | Templates
# and open the template in the editor.

class Application

  def initialize
    @behaviors = []
  end

  private
  def add_behavior(behavior)
    @behaviors << behavior
  end

  def load_behavior
    
  end

  attr_accessor :behaviors
end

Application.new