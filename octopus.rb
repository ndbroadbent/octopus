#!/usr/bin/env ruby
# Ruby class to read Octopus RFID tag ids with a 14333C compatible USB reader.
# Octopus tags begin with a ~ and have a length of 14 ASCII characters.

require 'rubygems'
require 'serialport'

class Octopus
  attr_accessor :port, :baud, :tag_length
  def initialize(port = "/dev/ttyUSB0", baud = 9600, tag_length = 14)
    @port, @baud, @tag_length = port, baud, tag_length
  end

  def read
    # Loops until an RFID tag is detected, and returns the tag id.
    tag_id = ""
    SerialPort.open @port, @baud do |sp|
      while true
        sp.read_timeout = 1
        v = sp.read
        if v.start_with?("~")   # If read string starts with "~", reset tag_id
          tag_id = v[1, v.size]
        elsif !v.empty?
          tag_id += v.strip
        end
        tag_id = tag_id.gsub("~", "").gsub("\n", "") if tag_id
        return tag_id if tag_id.size >= @tag_length
      end
    end
  end
end

