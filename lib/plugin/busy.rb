# To change this template, choose Tools | Templates
# and open the template in the editor.

class Busy < Plugin
  
  def send(message)
    message.reciptients = message.reciptients.select { |person| !person.busy? }
    
    if message.sender.busy?
      message.return_to_sender "You cannot chat while 'busy.'"
    end
    
    message
  end
end
