# To change this template, choose Tools | Templates
# and open the template in the editor.

class Plugin
  def initialize(application)
    @application = application
  end

  def install
    
  end
  
  def uninstall
    
  end
  
  def activate
    
  end
  
  def deactivate
    
  end
  
  def status_changed(previous, current)
    
  end

  # Allow plugins to alter incoming messages.
  def received(message)
    
  end

  def reciptients(message, reciptients)
    
  end
end
