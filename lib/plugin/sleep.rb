# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'plugin'

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
    command_regex = /^(\/sleep)(\s+((until|till)\s+)?((\d+\s*[:hm]?\s*)+)+(\s)*(([ap])\.?m\.?)?)?/i
    
    command = message.text.scan command_regex
    if (command.length)
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
      time_format = /(((\d)+)([hm:]))/i
      
      default_time = {:hours => :nil, :minutes => :nil}
#      command[0][4].scan time_format do |component|
#        if "m" == component[3]
#          default_time[:minutes] = component[1]
#        else
#          default_time[:hours] = component[1]
#        end
#      end
      
      # Time is relative
      base_date = Date.today
      if command[0][3].nil?
        base_date = Time.now
      end
      
      p base_date
    end
    
    message
  end
end
