class Graphite
  def self.notify(msg)
    system "echo '#{msg}' | nc localhost 2003"
  end
end
