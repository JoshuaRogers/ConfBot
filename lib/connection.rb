# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'xmpp4r'
require 'message'

class Connection
  def initialize(host, port = 5222)
    @host = host
    @port = port
    @client = nil
    @id = 0
  end

  def connect(username, password)
    @username = username
    @password = password

    jid = Jabber::JID::new("#{@username}/ConfBot")
    @client = Jabber::Client.new(jid) unless @client
    @client.connect(@host, @port)
    @client.auth(@password)
    
    self
  end

  def status(status)
    @client.send(Jabber::Presence.new.set_type(status))
    self
  end

  def disconnect
    @client.close if @client
    self
  end

  def send(recipient, text)
    @id += 1
    message = Jabber::Message.new(recipient, text).set_type(:chat).set_id(id)
    @client.send message
    self
  end

  def add_friend(address)
    presence = Jabber::Presence.new.set_type(:subscribe).set_to(address)
    @client.send presence
    self
  end

  def message_callback
    @client.add_message_callback { |m| yield create_message(m) }
  end

  def status_callback=
    @client.add_presence_callback { |s| yield s }
  end

  def update_callback=
    @client.add_update_callback { |u| yield u }
  end

  private
  def create_message(m)
    message = Message.new
    message.sender = m.from
    message.text = m.body
    message.timestamp = Time.now

    message
  end

end
