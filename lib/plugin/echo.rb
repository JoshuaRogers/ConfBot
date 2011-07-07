class Echo < Plugin
  def send(message)
    regex = /^\/echo\s/i
    if (message.text =~ regex)
      message.return_to_sender message.text.gsub(regex, "")
    end

    message
  end
end
