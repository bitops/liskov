class LineParser

  #
  # Extracts HTTP status code from log line.
  #
  def self.parse_line(l)
    l.gsub(/^.+\[(.+)\s.+\].+HTTP\/1.1" ([1-5])\d\d .+$/, "\\1 \\2")
  end

end
