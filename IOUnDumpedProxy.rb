# coding: utf-8
require 'drb'
require 'readline'
# Pry.config.input #=> Readline
# Pry.config.output #=> #<DRb::DRbObject:0x007ff0820c93e0  @ref=70208887076960,@uri="druby://127.0.0.1:58565">
puts -> {
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

  client = DRbObject.new(nil, "druby://127.0.0.1:58565")
  # 在原有的Readline输入,DRbObject输出的基础上加IO代理
  input = IOUndumpedProxy.new(Readline) #=> #<IOUndumpedProxy:0x007fef309ab6a0> # 这里可以直接读文件
  output = IOUndumpedProxy.new(client) #=> #<IOUndumpedProxy:0x007fb08f1b0908>
  
  #client.input  = input # DRb::DRbServerNotFound (DRb::DRbConnError)
  #client.output = output # DRb::DRbServerNotFound (DRb::DRbConnError)

  # 最终是从这里出去的
  #Pry.start(@object, @options.merge(:input => client.input_proxy,
  #                                  :output => client.output,
  #                                  :hooks => @hooks))

  # IOUndumpedProxy.new(Readline).readline("aaaa") #=> aaaa# coding: utf-8
  # ??? arity数量
  # IOUndumpedProxy.new(Readline).method(:readline).arity #=> 1

  # IOUndumpedProxy.new(Readline).puts(1111, 2222, 333) # private method `puts' called for Readline:Module (NoMethodError)
  # IOUndumpedProxy.new(Readline).print(1111, 2222, 333) # private method `print' called for Readline:Module (NoMethodError)
  
  nil
}[]
