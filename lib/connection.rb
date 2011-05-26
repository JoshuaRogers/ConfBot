# To change this template, choose Tools | Templates
# and open the template in the editor.

class Connection
  def initialize
    
  end

  def connect

  end

  def disconnect

  end

  def online

  end

  def offline
    !online
  end

  def send(message)
    
  end

  attr_accessor :username, :password, :host, :port, :ssl
end
