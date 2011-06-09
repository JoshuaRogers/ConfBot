# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'xmpp4r'

class Connection
  include Jabber

  def initialize(host, port = 5222)
    @host = host
    @port = port
    @client = nil
    @id = 0
  end

  def connect(username, password)
    @username = username
    @password = password

    jid = JID::new("#{@username}/ConfBot")
    @client = Client.new(jid) unless @client
    @client.connect(@host, @port)
    @client.auth(@password)
    
    self
  end

  def status(status)
    @client.send(Presence.new.set_type(status))
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
    presence = Presence.new.set_type(:subscribe).set_to(address)
    @client.send presence
    self
  end

  def message_callback
    @client.add_message_callback do |m|
      puts m
    end
  end

  def status_callback
    @client.add_presence_callback do |s| end
  end

  def update_callback
    @client.add_update_callback do |s| end
  end

end
