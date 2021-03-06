class IOUndumpedProxy
  include DRb::DRbUndumped

  def initialize(obj)
    @obj = obj
  end

  def completion_proc=(val)
    if @obj.respond_to? :completion_proc=
                        @obj.completion_proc = proc { |*args, &block| val.call(*args, &block) }
    end
  end

  def completion_proc
    @obj.completion_proc if @obj.respond_to? :completion_proc
  end

  def readline(prompt)
    if Readline == @obj
      @obj.readline(prompt, true)
    elsif @obj.method(:readline).arity == 1
      @obj.readline(prompt)
    else
      $stdout.print prompt
      @obj.readline
    end
  end

  def puts(*lines)
    @obj.puts(*lines)
  end

  def print(*objs)
    @obj.print(*objs)
  end

  def printf(*args)
    @obj.printf(*args)
  end

  def write(data)
    @obj.write data
  end

  def <<(data)
    @obj << data
    self
  end

  # Some versions of Pry expect $stdout or its output objects to respond to
  # this message.
  def tty?
    false
  end
end
