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
  end

  def connect(username, password)
    @username = username
    @password = password

    jid = JID::new("#{@username}/ConfBot")
    @client = Client.new(jid) unless @client
    @client.connect(@host, @port)
    @client.auth(@password)
  end

  def reconnect
    connect(@username, @password) if @client
  end

  def disconnect
    @client.close if @client
  end

  def send(recipient, message)
    
  end
end
