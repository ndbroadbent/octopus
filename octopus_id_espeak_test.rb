#!/usr/bin/env ruby
# Reads octopus cards and says the associated name. (requires 'espeak')
# -- If card ID is recognized, computer will say "Hello, #{name}!".
# -- If not, it will prompt for a name, for the given card ID.
require 'octopus'

def say(str)
  puts ":: #{str}"
  `espeak \"#{str}\" --stdout | aplay`
end

o = Octopus.new "/dev/ttyUSB0", 9600, 14
id_hash = {}

while true
  id = o.read
  if name = id_hash[id]
    say "Hello, #{name}!"
  else
    print "Please enter a name for RFID tag '#{id}': "
    id_hash[id] = gets.chomp
  end
end

