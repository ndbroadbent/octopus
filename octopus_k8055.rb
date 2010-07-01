#!/usr/bin/env ruby
require 'octopus'
require 'rubyk8055'
include USB

@off_delay = 0.4

@r = RubyK8055.new
@r.connect

@r.clear_all_digital

o = Octopus.new "/dev/ttyUSB0", 9600, 14
id_hash = {}

while true
  id = o.read
  if channel = id_hash[id]
    @r.set_digital channel.to_i, false
    # Clears the channel after certain delay.
    Thread.new { sleep @off_delay; @r.set_digital channel.to_i, false }
  else
    print "Please enter a channel for this RFID tag '#{id}': "
    id_hash[id] = gets.chomp
  end
end

