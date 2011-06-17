# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'xmpp4r'
require 'xmpp4r/roster'
require 'message'
require 'user'

class Connection
  def initialize(host, port = 5222)
    @host = host
    @port = port
    @client = nil
    @id = 0
    
    @users = []
  end

  def connect(username, password)
    @username = username
    @password = password

    jid = Jabber::JID::new("#{@username}/ConfBot")
    @client = Jabber::Client.new(jid) unless @client
    @client.connect(@host, @port)
    @client.auth(@password)
    
    @roster = Jabber::Roster::Helper.new(@client)
    @roster.wait_for_roster
    @roster.items.each { |name, r| @users << User.new(r) }
    
    @roster.add_presence_callback do |r, old, new|
      @users.detect{ |u| u.jid == r.jid }.presence = new
    end
    
    self
  end

  def available
    @client.send(Jabber::Presence.new.set_type(:available))
    self
  end

  def disconnect
    @client.close if @client
    self
  end

  def send(recipient, text)
    @id += 1
    message = Jabber::Message.new(recipient, text).set_type(:chat).set_id(@id)
    @client.send message
    self
  end

  def add_friend(address)
    presence = Jabber::Presence.new.set_type(:subscribe).set_to(address)
    @client.send presence
    self
  end

  def message_callback=(callback)
    @client.add_message_callback do |m|
      
      # Messages were being fired off when a user would first start typing.
      # This should filter out the "xyz is typing." message.
      callback.call create_message(m) unless m.body.nil?
    end
  end

  def update_callback=(callback)
    @roster.add_update_callback { |x, y| callback.call(x, y) }
  end
  
  private
  def create_message(m)
    s = Jabber::JID.new(m.from)
    
    message = Message.new
    message.sender = @users.detect{ |u| u.address == s.node + "@" + s.domain }
    message.text = m.body
    message.timestamp = Time.now
    message.reciptients = @users.select { |u| u.online? and u != message.sender }

    message
  end

end
