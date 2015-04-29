class LogReader

  attr_accessor :batch

  DEFAULT_BATCH_SIZE = 25

  def self.start(f)
    reader = self.new f
    yield reader
    reader.loop
  end

  # 
  # initializes an IO object
  # with reader position set 
  # to the end of the stream.
  #
  def initialize(f)
    @io = File.open(f)
    @io.seek(0, IO::SEEK_END)
    @count = 0
    @batch_size = DEFAULT_BATCH_SIZE
  end

  def on_line(&blk)
    @on_line = blk
  end

  def on_batch(&blk)
    @on_batch = blk
  end

  def loop
    Kernel.loop do
      while ( line  = @io.gets("\n") )
        @count += 1
        @on_line.call line
        if @count % @batch_size == 0
          @count = 0
          @on_batch.call
        end        
      end
    end
  end

end
