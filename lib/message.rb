# To change this template, choose Tools | Templates
# and open the template in the editor.

class Message
  def initialize
    @format = true
  end
  
  def print
    if @format
      "[" + sender.name + "] " + text
    else
      text
    end
  end
    
  def invalid?
    @sender.nil? or @text.empty? or @reciptients.empty?
  end

  attr_accessor :sender, :timestamp, :text, :reciptients, :format
end
