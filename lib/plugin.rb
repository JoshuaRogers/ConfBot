# To change this template, choose Tools | Templates
# and open the template in the editor.

class Plugin
  def self.inherited(child)
    @@subclasses << child
  end
  
  def self.list
    @@subclasses
  end
  
  def initialize(application)
    @application = application
  end
  
  def activate
    
  end
  
  def deactivate
    
  end
  
  # Allow plugins to alter messages before they are sent to a group.
  def send(message)
    message
  end
  
  def sort_order
    0
  end
  
  private
  @@subclasses = []
end
