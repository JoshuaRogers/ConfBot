class Backslash < Plugin
  def send(message)
    message.text = message.text.gsub(/^\\/i, "/")
    message
  end
  
  def sort_order
    -10
  end
end
