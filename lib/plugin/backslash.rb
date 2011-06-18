class Backslash < Plugin
  def send(message)
    message.text = message.text.gsub(/^\\/i, "/")
    message
  end
end
