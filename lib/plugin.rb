# To change this template, choose Tools | Templates
# and open the template in the editor.

class Plugin
  def self.inherited(child)
    @@subclasses << child
  end
  
  def self.list
    @@subclasses
  end
  
  # Called the first time that a plugin is loaded
  def install
    
  end
  
  # Called if the plugin has a different version than the db registered.
  def upgrade(version)
    
  end
  
  # Called when the plugin is started during initialization
  def activate
    
  end
  
  # Called when the chat server shuts down.
  def deactivate
    
  end
  
  # Allow plugins to alter messages before they are sent to a group.
  def send(message)
    message
  end
  
  # Identifies the version of the plugin.
  def version
    1
  end
  
  # Specifies what order the plugins should be run.  Lower numbers occur first.
  def sort_order
    0
  end
  
  private
  @@subclasses = []
end
