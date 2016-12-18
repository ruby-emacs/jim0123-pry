# coding: utf-8
require 'open3'
require 'drb'
require './IOUnDumpedProxy1'
puts -> {
  # Ensure that system (shell command) output is redirected for remote session.
  System = proc do |output, cmd, _|
    status = nil
    Open3.popen3 cmd do |stdin, stdout, stderr, wait_thr|
      stdin.close # Send EOF to the process
      
      until stdout.eof? and stderr.eof?
        if res = IO.select([stdout, stderr])
          res[0].each do |io|
            next if io.eof?
            output.write io.read_nonblock(1024)
          end
        end
      end

      status = wait_thr.value
    end

    unless status.success?
      output.puts "Error while executing command: #{cmd}"
    end
  end
  client = DRbObject.new(nil, "druby://127.0.0.1:58565")
  output = IOUndumpedProxy.new(client)
  #System.call(output, "/bin/ls") #=> undefined method `write' for nil:NilClass (NoMethodError)
  System.call($stdout,"/bin/ls",3) # 打印当前目录的文件

  nil
}[]
