require 'date'
require 'time'

class Timestamp

  FORMAT = "%d/%b/%Y:%H:%M:%S"

  def self.from_log(date_str)
    # ex: 28/Jan/2012:08:34:41
    dt = DateTime.strptime(date_str, FORMAT)
    Time.parse(dt.ctime).to_i
  end
end
