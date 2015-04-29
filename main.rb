#!/usr/bin/ruby
require File.expand_path(File.join(File.dirname(__FILE__), 'graph'))

# say a friendly goodbye if interrupted.
trap("INT") { puts "Caught interrupt! Shutting down."; exit 0 }

# main program.
LOG_LOCATION = "/var/log/challenge/example.log"

Graph.generate_from LOG_LOCATION
