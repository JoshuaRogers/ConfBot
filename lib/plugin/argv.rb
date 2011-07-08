class Argv < Plugin
  
  def activate
    # Map the different commands to their methods.
    mapping = {
      "-a"     => method("add"),
      "--add"  => method("add"),
      "-h"     => method("help"),
      "--help" => method("help"),
    }

    # Parse the argument 
    args = ARGV.join(" ").scan(/[A-Z0-9\-\:@\.]*\w/i)
    
    unless args.empty?
      while (arg = args.shift) do
        callee = mapping[arg] || method("help")
        if callee and callee.parameters.length <= args.length
          parameters = callee.parameters.length
          parameters > 0 ? callee.call(args.slice!(0, parameters)) : callee.call
        else
          puts "[Error: Missing parameters]"
          print arg, " expected ", callee.parameters.length, " argument(s)."
          puts
          help
          break
        end
      end
      exit
    end
  end
  
  def add(connection_string)
    p "Add connection ", connection_string
  end
  
  def help
    puts %q{
ConfBot, a group chat provider for Jabber.
Usage: confbot.rb [OPTION]

Connection
  -a,  --add USER@HOST:[PORT]    Add connection
  -l,  --list                    List connections
  -p,  --password ID             Set password
  -r,  --remove ID               Removes a given connection

General
  -h,  --help                    This message
       --reset-database          Remove the database file

Mail bug reports and suggestions to <bug-confbot@joshuarogers.net>.
    }
    exit
  end
  
  # Run this first since it displays messages on the command line.
  def sort_order
    -100
  end
end
