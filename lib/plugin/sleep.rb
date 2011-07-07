class Sleep < Plugin
  def initialize
    @sleepers = {}
  end
  
  def send(message)
    # Regex matches the following formats:
    #   /sleep
    #   /sleep until 5:30 P.M.
    #   /sleep till 5:30
    #   /sleep 3h37m
    #
    # Indices:
    #   [0][0]: /sleep
    #   [0][3]: till, until or nil
    #   [0][4]: time
    #   [0][8]: a, p, or nil (for am or pm)
    sleep_regex = /^(\/sleep)(\s+((until|till)\s+)?((\d+\s*[:hm]?\s*)+)+(\s)*(([ap])\.?m\.?)?)?/i
    
    # Regex matches the following formats:
    #   /wake
    #   /wake up
    #   /awake
    #   /awaken
    wake_regex = /^(\/[a]?wake[n]?(\s+up)?)/i
    
    # See if a /sleep command has been given.
    if (message.text.match sleep_regex)
      command = message.text.scan sleep_regex
    
      # Should we use an absolute time or a relative time?
      quiet_time = command[0][3].nil? ? Time.now : Date.today.to_time
      
      # Offset the time from our starting point
      quiet_time += parse_time(command[0][4])
      
      # Adjust for pm if it is specified.
      quiet_time += parse_time("12h") if command[0][8] == "p"
      
      # If the specified time is past, find the next instance of it.
      while (Time.now >= quiet_time) do
        quiet_time += parse_time(command[0][8].nil? ? "12h" : "24h")
      end
      
    # If there is no sleep, check for /wake.
    elsif message.text.match wake_regex

    end
    
    message
  end
  
  private
  def parse_time(time)
    # Regex matches the following time specifications:
    #   2h30m
    #   2:30
    #   2h 30m
    #
    # Produces array for each matching component.
    #
    # Indices:
    # [n][1] The number portion
    # [n][3] The metric: h or : for hour, or m for minute
    time_format = /(((\d)+)([hm:])?)/i

    time_offset = 0
    time.scan time_format do |component|
      time_offset += Integer(component[1]) * (["h", ":"].include?(component[3]) ? 60 : 1)
    end

    # Convert our minute offset into seconds.    
    time_offset * 60
  end
end
