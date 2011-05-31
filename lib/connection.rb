# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'xmpp4r-simple'

class Connection
  def initialize(host, port, username, password, ssl)
    @host = host
    @port = port
    @username = username
    @password = password
    @ssl = ssl
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

  attr_accessor :host, :port, :username, :password, :ssl
end
