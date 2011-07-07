class Me < Plugin
  def send(message)
    regex = /^\/me\s/i
    if (message.text =~ regex)
      message.text = message.text.gsub(regex, message.sender.name + " ")      
      message.format = false
      message.reciptients << message.sender
    end
    
    message
  end
end
