require 'plugin'

class Echo < Plugin
  def send(message)
    regex = /^\/echo\s/i
    if (message.text =~ regex)
      message.text = message.text.gsub(regex, "")
      message.format = false
      message.return_to_sender
    end

    message
  end
end
