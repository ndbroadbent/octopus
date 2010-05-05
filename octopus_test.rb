#!/usr/bin/env ruby
# Demonstrates the 'Octopus' class for reading RFID tags.
require 'octopus'

o = Octopus.new "/dev/ttyUSB0", 9600, 14
puts "--- Polling for RFID tags ---"

while true
  puts o.read
end

