puts -> {
  InputProxy = Struct.new :input do
    # Reads a line from the input
    def readline(prompt)
#      open("/Users/emacs/aaa.log",'a') { |f|
#        f.puts "prompt:#{prompt}__#{prompt.class}" ##=> prompt:[1] pry(#<Foo>)> __String
#        f.puts "input:#{input}__#{input.class}"  ##=> input:#<PryRemote::IOUndumpedProxy:0x007fb592145f88>__DRb::DRbObject
#      }
      case readline_arity
      when 1 then input.readline(prompt)
      else        input.readline
      end
    end

    def completion_proc=(val)
      input.completion_proc = val
    end

    def readline_arity
      input.method_missing(:method, :readline).arity
    rescue NameError
      0
    end
  end

  (InputProxy.new "aaa").readline_arity # => 0
  (InputProxy.new "aaa").readline("bbb") #=> private method `readline' called for "aaa":String
  
  
}[]
