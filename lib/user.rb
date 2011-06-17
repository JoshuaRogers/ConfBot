# To change this template, choose Tools | Templates
# and open the template in the editor.

class User
  def initialize(ri)
    @jid = ri.jid
    #@subscription = ri.subscription
    @name = ri.name
  end

  # Boolean indicating if the user is available.
  def available?
    online? and (presence.show == nil or presence.show == :chat)
  end

  # Boolean indicating if the user is away.
  def away?
    online? and (presence.show == :away or presence.show == :xa)
  end

  # Boolean indicating if the user is busy.
  def busy?
    online? and presence.show == :dnd
  end

  # Boolean indicating if the user is offline.
  def offline?
    !online?
  end

  # Boolean indicating if the user is online.
  def online?
    @presence && @presence.type == nil
  end
  
  def address
    @jid.node + "@" + @jid.domain
  end
  
  def name
    @name or address
  end
  
  attr_accessor :presence, :jid
  
end
