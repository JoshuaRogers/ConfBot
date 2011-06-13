# To change this template, choose Tools | Templates
# and open the template in the editor.

class User
  def initialize(jid, connection)
    @jid = jid
    @connection = connection
  end

  # Boolean indicating if the user is available.
  def available?

  end

  # Boolean indicating if the user is away.
  def away?

  end

  # Boolean indicating if the user is busy.
  def busy?

  end

  # Boolean indicating if the user is offline.
  def offline?
    !online
  end

  # Boolean indicating if the user is online.
  def online?

  end

  # String containing the user's current status
  def status
    
  end

  # Sends a message to a given user
  def send(m)
    message = m is Message ? m.print : m
    @connection.send(jid, message)  
  end
  
  def defriend
    
  end
  
  attr_accessor :status
end
