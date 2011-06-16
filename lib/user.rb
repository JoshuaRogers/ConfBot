# To change this template, choose Tools | Templates
# and open the template in the editor.

class User
  def initialize(ri)
    @jid = ri.jid
    @subscription = ri.subscription
    @name = ri.name
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
  
  def name
    @name
  end
  
  def status=(s)
    
  end
end
