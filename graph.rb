require File.expand_path(File.join(File.dirname(__FILE__), 'log_reader'))
require File.expand_path(File.join(File.dirname(__FILE__), 'timestamp'))
require File.expand_path(File.join(File.dirname(__FILE__), 'line_parser'))
require File.expand_path(File.join(File.dirname(__FILE__), 'aggregator'))
require File.expand_path(File.join(File.dirname(__FILE__), 'graphite'))

class Graph

  def self.generate_from(location)
    aggr = Aggregator.new
    LogReader.start(location) do |lr|
      
      lr.on_line do |l|
        datetime, code = LineParser.parse_line(l).split
        timestamp = Timestamp.from_log datetime
        data = aggr.metrics[code.to_i]
        aggr.add timestamp, data
      end
      
      lr.on_batch do
        data = aggr.exhume
        # roll up
        msgs = data.map {|time, metrics| metrics.map {|k,v| "#{k} #{v} #{time}" } }.flatten
        # transmit
        msgs.each {|msg| Graphite.notify msg }
      end

    end
  end

end
