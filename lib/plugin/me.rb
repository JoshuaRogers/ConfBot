# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'plugin'

class Me < Plugin
  def initialize
    
  end

  def send(message)
    message.text = message.text.gsub(/^\/me\s/i, "I ")
    
    message
  end
end
