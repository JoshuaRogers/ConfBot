# To change this template, choose Tools | Templates
# and open the template in the editor.

class Plugin
  def activate
    
  end
  
  def deactivate
    
  end
  
  # Allow plugins to alter messages before they are sent to a group.
  def send(message, reciptients)
    return message, reciptients
  end

  attr_reader :name, :version, :description
end
