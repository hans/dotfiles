require 'rubygems'
require 'irb/completion'
require 'pp'

require 'wirble'
Wirble.init
Wirble.colorize

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:USE_READLINE] = true

class Object
  def local_methods
    p self.methods.sort - self.class.superclass.methods
  end
end
