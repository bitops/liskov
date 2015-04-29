class Aggregator

  attr_reader :metrics

  def initialize
    # map first digit of HTTP status
    # response code to graph name.
    @metrics = {
      1 => "local.sebastian.http_1xx",
      2 => "local.sebastian.http_2xx",
      3 => "local.sebastian.http_3xx",
      4 => "local.sebastian.http_4xx",
      5 => "local.sebastian.http_5xx"
    }
    reset
  end

  def add(ts, metric)
    init_count_for ts
    incr_count_for ts, metric
  end

  def exhume
    data = @data
    reset
    data
  end

  private
  def reset
    @data = {}
  end

  def init_count_for(ts)
    @data[ts] ||= {}
    @metrics.values.each do |metric| 
      @data[ts][metric] ||= 0
    end
  end

  def incr_count_for(ts, metric)
    @data[ts][metric]  += 1
  end

end
