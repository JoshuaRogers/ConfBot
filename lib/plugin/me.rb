# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'plugin'

class Me < Plugin
  def initialize
    
  end

  def send(message)
    regex = /^[\/|\\]me\s/i
    if (message.text =~ regex)
      message.text = message.text.gsub(regex, message.sender.name + " ")      
      message.format = false
    end
    
    message
  end
end
