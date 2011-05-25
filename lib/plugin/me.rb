# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'plugin'

class Me < Plugin
  def initialize
    
  end

  def matches(message)
    message.text.scan(/\/me\s(.*)/i)
  end
end
